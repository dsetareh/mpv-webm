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
			"--ovcopts-add=preset=#{options.mp4_preset}"
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
			"--ovcopts-add=preset=#{options.mp4_preset}",
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
			-- nvenc fix thanks to advice from plugin creator (https://github.com/ekisu/mpv-webm/pull/175)
			"--ovcopts-add=bf=0",
			-- rest is stuff to make the encode better (hopefully)
			"--ovcopts-add=profile=high",
			"--ovcopts-add=rc=vbr",
			"--ovcopts-add=refs=2",
			"--ovcopts-add=tune=hq",
			"--ovcopts-add=preset=#{options.nvenc_preset}",
			-- fix crf for nvenc
			"--ovcopts-add=cq=#{options.crf}"
		}
formats["mp4-nvenc"] = AVCNVENC!
