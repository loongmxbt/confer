评阅
review 由 professor 创建

一条review由一个paper，一个prof，一个status，一个content
review
has_one paper
has_one professor

paper_id belongs_to paper
user_id (role = prefessor)
status
content

每条review记录有一个status，对应一个paper和一个user
mix phoenix.gen.html Review reviews status_id:references:statuses paper_id:references:confers user_id:references:users content:text

mix phoenix.gen.model Status statuses name:string

先自动生成 reviews 条目，有 user_id <=> paper_id -> status(waiting) and content("")

列表：
papers  ||   professors
100          10

paper has_many reviews (3个)

user role 为教授，可以在自己的页面里看到我的评阅

backend 只为admin服务，可以分配论文评阅，看到全局的论文评阅情况

也就是说教授并没有backend的权限


评阅意见 删除
<table class="table">
  <thead>
    <tr><th width="20%">评阅意见</th><th>内容详情</th></tr>
  </thead>
  <tbody>
    <%= for review <- @reviews do %>
    <tr>
      <th><%= raw review_label(review.status_id) %></th>
      <td>
        <%= review.content %>
      </td>
    </tr>
    <% end %>
  </tbody>
</table>
