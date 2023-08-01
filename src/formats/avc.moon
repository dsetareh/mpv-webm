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
