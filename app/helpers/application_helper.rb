module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new #建立新的summaries等
    id = new_object.object_id #提取id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
      link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
  
  def remove_unwanted_words string
    bad_words=["上海","南京","北京","广州","years","about","less","over","more"," a ","than","minute","hour","month","day","second","s"," "]
    bad_words.each do |f|
    string.gsub!(f,'')
    end
    return string.present? ? string: "0"
  end
end
