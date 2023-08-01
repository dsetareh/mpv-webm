class AVC extends Format
	new: =>
		@displayName = "h264/AAC"
		@supportsTwopass = true
		@videoCodec = "libx264"
		@audioCodec = "aac"
		@outputExtension = "mp4"
		@acceptsBitrate = true

	getFlags: =>
		{
			"--ovcopts-add=threads=#{options.threads}",
		}

formats["mp4"] = AVC!

class AVCCOMPAT extends Format
	new: =>
		@displayName = "h264/AAC (COMPAT)"
		@supportsTwopass = true
		@videoCodec = "libx264"
		@audioCodec = "aac"
		@outputExtension = "mp4"
		@acceptsBitrate = true

	getFlags: =>
		{
			"--ovcopts-add=threads=#{options.threads}",

			-- everything below are personal hardcoded ffmpeg opts
			-- due to one person having issues watching clips
			-- (dont know which one of these fixed it, and cant recreate issue)
            -- see: https://github.com/mpv-player/mpv/blob/master/DOCS/encoding.rst
			"--ovcopts-add=preset=medium",
			"--ovcopts-add=profile=baseline",
			"--ovcopts-add=level=41",
			"--ovcopts-add=refs=2"
		}

formats["mp4-compat"] = AVCCOMPAT!

class AVCNVENC extends Format
	new: =>
		@displayName = "h264/AAC (NVENC)"
		@supportsTwopass = true
		@videoCodec = "h264_nvenc"
		@audioCodec = "aac"
		@outputExtension = "mp4"
		@acceptsBitrate = true
	getFlags: =>
		{
			-- nvenc fix for my machine
			-- nothing above p2 works for me
			"--ovcopts-add=preset=p2",
			-- rest is stuff to make the encode better (hopefully)
			"--ovcopts-add=profile=high",
			"--ovcopts-add=rc=vbr",
			"--ovcopts-add=refs=2",
			"--ovcopts-add=tune=hq",
			-- fix crf for nvenc
			"--ovcopts-add=cq=#{options.crf}"
		}
formats["mp4-nvenc"] = AVCNVENC!
