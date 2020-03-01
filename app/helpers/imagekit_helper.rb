module ImagekitHelper
  def imagekit_url(uid, tr: {})
    if tr.present?
      transformation_path = tr.map { |key, val| "#{key}-#{val}" }.join(",")
      "https://ik.imagekit.io/uabooks/tr:#{transformation_path}/#{uid}"
    else
      "https://ik.imagekit.io/uabooks/#{uid}"
    end
  end

  # Adds 2x and 3x sources using "dpr" param, see
  # https://docs.imagekit.io/features/image-transformations/resize-crop-and-other-transformations
  def imagekit_hd_image_tag(uid, options)
    transformations = options.fetch(:tr)
    image_tag_options = options.except(:tr)

    srcsets = [2, 3].map do |pixel_ratio|
      "#{imagekit_url(uid, tr: transformations.merge(dpr: pixel_ratio))} #{pixel_ratio}x"
    end
    srcset = srcsets.join(", ")

    base_url = imagekit_url(uid, tr: transformations)

    image_tag(base_url, image_tag_options.merge(srcset: srcset))
  end
end
