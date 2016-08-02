javascripts: {
  joinTo: {
    "js/app.js": /^(web\/static\/js)|(node_modules)/,
    "js/ex_admin_common.js": ["web/static/vendor/ex_admin_common.js"],
    "js/admin_lte2.js": ["web/static/vendor/admin_lte2.js"],
    "js/jquery.min.js": ["web/static/vendor/jquery.min.js"],
    "js/bootstrap.min.js": ["web/static/vendor/bootstrap.min.js"],
    "js/simditor.min.js": ["web/static/vendor/simditor/module.min.js",
                           "web/static/vendor/simditor/hotkeys.min.js",
                           "web/static/vendor/simditor/uploader.min.js",
                           "web/static/vendor/simditor/simditor.min.js"]
  },

修改 admin_lte2.html.eex

添加 simditor.min.js
<link rel="stylesheet" href="<%= static_path(@conn, "/css/simditor.css") %>">
<script src="<%= static_path(@conn, "/js/simditor.min.js") %>"></script>

var editor = new Simditor({
  textarea: $('textarea'),
  defaultImage: 'http://temp.im/150x150',
  toolbar: ['title', 'bold', 'italic', 'underline', 'strikethrough', 'fontScale', 'color', 'ol', 'ul', 'blockquote', 'table', 'link', 'image', 'hr', 'indent', 'outdent', 'alignment']
});

var editor = new Simditor({
  textarea: $('textarea'),
  toolbar: [
    'title',
    'bold',
    'italic',
    'underline',
    'strikethrough',
    'fontScale',
    'color',
    'ol',
    'ul',
    'blockquote',
    'table',
    'link',
    'image',
    'hr',
    'indent',
    'outdent',
    'alignment'
  ]
});
