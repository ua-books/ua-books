class UploadcareInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    model = @builder.object
    tags = []
    tags << template.javascript_include_tag("https://ucarecdn.com/libs/widget/3.x/uploadcare.full.min.js", async: true)

    url = model.public_send(attribute_name)
    if url
      tags << template.image_tag(Uploadcare.url(url, resize: "x100"))
    end

    tags << @builder.hidden_field(attribute_name, widget_options)
    safe_join(tags)
  end

  private

  # https://uploadcare.com/docs/file_uploads/widget/options
  def widget_options(valid_to: 10.minutes.since)
    {
      "role" => "uploadcare-uploader",
      "data-public-key" => Uploadcare::CONFIG.fetch("public_key"),
      "data-secure-signature" => Uploadcare.signature(valid_to),
      "data-secure-expire" => valid_to.to_i,
    }
  end
end
