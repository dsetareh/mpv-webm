class AVC extends Format
	new: =>
		@displayName = "AVC (h264/AAC)"
		@supportsTwopass = true
		@videoCodec = "libx264"
		@audioCodec = "aac"
		@outputExtension = "mp4"
		@acceptsBitrate = true

	getFlags: =>
		{
			"--ovcopts-add=threads=#{options.threads}"
		}

formats["mp4"] = AVC!

class AVCNVENC extends Format
	new: =>
		@displayName = "AVC (h264-NVENC/AAC)"
		@supportsTwopass = true
		@videoCodec = "h264_nvenc"
		@audioCodec = "aac"
		@outputExtension = "mp4"
		@acceptsBitrate = true

formats["mp4-nvenc"] = AVCNVENC!
