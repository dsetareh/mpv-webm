class MainPage extends Page
	new: =>
		@keybinds =
			"c": self\crop
			"1": self\setStartTime
			"2": self\setEndTime
			"!": self\jumpToStartTime
			"@": self\jumpToEndTime
			"o": self\changeOptions
			"p": self\preview
			"e": self\encode
			"ESC": self\hide
		@startTime = -1
		@endTime = -1
		@region = Region!

	setStartTime: =>
		@startTime = mp.get_property_number("time-pos")
		if @visible
			self\clear!
			self\draw!

	setEndTime: =>
		@endTime = mp.get_property_number("time-pos")
		if @visible
			self\clear!
			self\draw!

	jumpToStartTime: =>
		mp.set_property("time-pos", @startTime)

	jumpToEndTime: =>
		mp.set_property("time-pos", @endTime)

	setupStartAndEndTimes: =>
		if mp.get_property_native("duration")
			-- Note: there exists an option called rebase-start-time, which, when set to no,
			-- could cause the beginning of the video to not be at 0. Not sure how this
			-- would affect this code.
			@startTime = 0
			@endTime = mp.get_property_native("duration")
		else
			@startTime = -1
			@endTime = -1
		
		if @visible
			self\clear!
			self\draw!

	draw: =>
		window_w, window_h = mp.get_osd_size()
		ass = assdraw.ass_new()
		ass\new_event()
		self\setup_text(ass)
		-- ass\append("#{bold('WebM maker')}\\N\\N")
		ass\append("\\N[#{bold(seconds_to_time_string(@startTime))}-#{bold(seconds_to_time_string(@endTime))}](#{options.video_speed}x)\\N")
		-- get source and output video properties
		source_fps = mp.get_property_number("container-fps")
		source_height = mp.get_property("height")
		source_width = mp.get_property("width")
		source_ratio = source_width / source_height
		output_height = options.scale_height
		output_fps = options.fps
		if output_height < 0
			output_height = source_height
		output_width = output_height * source_ratio
		if output_width > 8192
			ass\append("(#{bold('Width above 8192, no NVENC support!')})\\N\\N")
		if output_fps < 0
			output_fps = source_fps
		ass\append("#{source_height}p#{math.floor(source_fps)} -> #{output_height}p#{math.floor(output_fps)}")
		if @startTime >= @endTime or @startTime == @endTime
			ass\append("(#{bold('Invalid length!')})\\N\\N")
		else	
			ass\append("(#{bold(normalized_length_to_time_string((@endTime - @startTime) / options.video_speed))})\\N\\N")
		ass\append("#{bold('[C]')}rop\\N")
		ass\append("#{bold('[O]')}ptions\\N")
		ass\append("#{bold('[E]')}ncode\\N")
		mp.set_osd_ass(window_w, window_h, ass.text)
	
	show: =>
		super\show!

		emit_event("show-main-page")

	onUpdateCropRegion: (updated, newRegion) =>
		if updated
			@region = newRegion
		self\show!

	crop: =>
		self\hide!
		cropPage = CropPage(self\onUpdateCropRegion, @region)
		cropPage\show!

	onOptionsChanged: (updated) =>
		self\show!

	changeOptions: =>
		self\hide!
		encodeOptsPage = EncodeOptionsPage(self\onOptionsChanged)
		encodeOptsPage\show!

	onPreviewEnded: =>
		self\show!

	preview: =>
		self\hide!
		previewPage = PreviewPage(self\onPreviewEnded, @region, @startTime, @endTime)
		previewPage\show!

	encode: =>
		self\hide!
		if @startTime < 0
			message("No start time, aborting")
			return
		if @endTime < 0
			message("No end time, aborting")
			return
		if @startTime >= @endTime
			message("Start time is ahead of end time, aborting")
			return
		encode(@region, @startTime, @endTime)
