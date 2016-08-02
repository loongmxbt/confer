paper

title:string
file_name:string
file_url:string
topic_id

mix phoenix.gen.html Paper papers title:string file_name:string file_url:string

mix ecto.gen.migration add_topic_id_to_paper
mix ecto.gen.migration add_user_id_to_paper

%{"file" => %Plug.Upload{content_type: "image/png",
   filename: "签名钢笔.PNG",
   path: "/var/folders/wl/8_mrlnx52ls04sfl1my7g7l80000gn/T//plug-1469/multipart-1787-405592-1"},
  "title" => "asdfadf", "topic_id" => "1"}

https://github.com/stavro/arc 274 stars
https://github.com/keichan34/exfile 31 stars
