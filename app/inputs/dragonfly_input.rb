# Displays uploaded image thumbnail (when present) + file input
class DragonflyInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    model = @builder.object
    tags = []

    # http://markevans.github.io/dragonfly/models#reflection-methods
    # http://markevans.github.io/dragonfly/models#retaining-across-form-redisplays
    if model.public_send("#{attribute_name}_stored?")
      attachment = model.public_send(attribute_name)
    else
      attachment = model.public_send("retained_#{attribute_name}")
    end

    if attachment
      tags << template.image_tag(attachment.thumb("x100").url)
    end

    tags << @builder.file_field(attribute_name, merged_input_options)
    tags << @builder.hidden_field("retained_#{attribute_name}")
    safe_join(tags)
  end
end
