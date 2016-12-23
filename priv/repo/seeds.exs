# mix run priv/repo/seeds.exs
alias Confer.Repo
alias Confer.User
alias Confer.Role
alias Confer.Topic
alias Confer.Page
alias Confer.Status
alias Confer.Review
alias Confer.Paper
alias Confer.Post
alias Confer.Info


# Add Roles
Repo.delete_all Role
for role_name <- ~w(user professor admin) do
  Repo.insert!(%Role{name: role_name})
end

# Add topics
Repo.delete_all Topic
for topic_name <- ["基础热力学", "热力系统循环", "热泵、制冷空调", "材料热物性", "可再生能源、脱碳、储能等"] do
  Repo.insert!(%Topic{name: topic_name})
end

# Add Users
Repo.delete_all User
User.changeset(%User{}, %{name: "dragonszy", email: "dragonszy@163.com", password: "szy555", password_confirmation: "szy555", role_id: 3})
|> Repo.insert!
# |> Coherence.ControllerHelpers.confirm!

User.changeset(%User{}, %{name: "phoenixfbi", email: "phoenixfbi@163.com", password: "fbi555", password_confirmation: "fbi555", role_id: 1})
|> Repo.insert!
# |> Coherence.ControllerHelpers.confirm!

if Mix.env == :dev do
for i <- 1..5 do
  User.changeset(%User{}, %{name: "用户#{i}", email: "user#{i}@163.com", password: "user555", password_confirmation: "user555", role_id: 1})
  |> Repo.insert!
end

for i <- 1..20 do
  User.changeset(%User{}, %{name: "教授#{i}", email: "prof#{i}@163.com", password: "prof555", password_confirmation: "prof555", role_id: 2, topic_id: rem(i, 5)+1 })
  |> Repo.insert!
end
end



# Add pages
welcome_text = "<p>热力学是研究热现象中，物质系统在平衡时的性质和建立能量的平衡关系，以及状态发生变化时，系统与外界相互作用的学科。
工程热力学是热力学最先发展的一个分支，它主要研究热能与机械能和其他能量之间相互转换的规律及其应用，是机械工程的重要基础学科之一。</p>
<p>根据中国工程热物理学会工程热力学与能源利用分会专业委员会的安排，2016年中国工程热物理学会程热力学与能源利用学术年会将于2016年11月9日-12日在广东举行。
会议将围绕基础热力学、热力系统循环、热泵制冷空调、材料热物性和可再生能源、脱碳、储能等5个专题开展交流，旨在展示我国工程热力学与能源利用领域的新成果，碰撞出燃烧研究的新火花，挑战遇到的新问题。
大会由国家自然科学基金委工程与材料科学部工程科学三处和中国工程热物理学会燃烧学分会主办，广东工业大学大学和中科院广州能源所承办。会议将由大会邀请报告、专题报告、基金进展报告以及各专题的分组报告构成。</p>
<p>我们相信，通过此次工程热力学与能源利用学术会议，将会加深全国各地的研究人员的交流合作。</p>
<p>欢迎各地研究人员参会交流！</p>"

organization_text = """
<table class="table table-striped">
  <thead><tr><th>主任：</th><th><br></th></tr></thead>
  <tbody><tr><td>杨勇平</td><td>华北电力大学</td></tr></tbody>
</table>
<table class="table table-striped">
  <thead><tr><th>副主任：</th><th><br></th></tr></thead>
  <tbody>
    <tr><td>段远源<br></td><td>清华大学<br></td></tr>
    <tr><td>李小森<br></td><td>中国科学院广州能源研究所<br></td></tr>
    <tr><td>宋永臣<br></td><td>大连理工大学<br></td></tr>
    <tr><td>陈林根<br></td><td>中国人民解放军海军工程大学<br></td></tr>
    <tr><td>于达仁<br></td><td>哈尔滨工业大学<br></td></tr>
  </tbody>
</table>
<table class="table table-striped">
  <thead><tr><th>委员：</th><th><br></th></tr></thead>
  <tbody>
    <tr><td>陈光明<br></td><td>浙江大学<br></td></tr>
    <tr><td>吴静怡<br></td><td>上海交通大学<br></td></tr>
    <tr><td>何茂刚<br></td><td>西安交通大学<br></td></tr>
    <tr><td>严俊杰<br></td><td>西安交通大学<br></td></tr>
    <tr><td>杨昭<br></td><td>天津大学<br></td></tr>
    <tr><td>刘朝<br></td><td>重庆大学<br></td></tr>
    <tr><td>公茂琼<br></td><td>中国科学院理化技术研究所<br></td></tr>
    <tr><td>郑丹星<br></td><td>北京化工大学<br></td></tr>
    <tr><td>王永青<br></td><td>集美大学<br></td></tr>
    <tr><td>陈颖<br></td><td>广东工业大学<br></td></tr>
    <tr><td>张小松<br></td><td>东南大学<br></td></tr>
    <tr><td>潘卫国<br></td><td>上海电力学院<br></td></tr>
    <tr><td>汪建文<br></td><td>内蒙古工业大学<br></td></tr>
  </tbody>
</table>
"""



Repo.delete_all Page
Page.changeset(%Page{}, %{title: "组委会致欢迎辞", slug: "welcome", content: welcome_text})
|> Repo.insert!

Page.changeset(%Page{}, %{title: "组织结构", slug: "organization", content: organization_text})
|> Repo.insert!

Page.changeset(%Page{}, %{title: "重要日期", slug: "dates", content: "content here"})
|> Repo.insert!

Page.changeset(%Page{}, %{title: "参会注册", slug: "meeting", content: "content here"})
|> Repo.insert!

Page.changeset(%Page{}, %{title: "交通住宿", slug: "travel", content: "content here"})
|> Repo.insert!

Page.changeset(%Page{}, %{title: "会议专题", slug: "topics", content: "content here"})
|> Repo.insert!

Page.changeset(%Page{}, %{title: "特邀报告", slug: "reports", content: "content here"})
|> Repo.insert!

Page.changeset(%Page{}, %{title: "文档下载", slug: "downloads", content: "content here"})
|> Repo.insert!

Page.changeset(%Page{}, %{title: "会议日程", slug: "calendar", content: "content here"})
|> Repo.insert!

Page.changeset(%Page{}, %{title: "联系我们", slug: "contact", content: "content here"})
|> Repo.insert!

# Status
Repo.delete_all Status
Status.changeset(%Status{}, %{name: "等待评阅"}) |> Repo.insert!
Status.changeset(%Status{}, %{name: "评阅通过"}) |> Repo.insert!
Status.changeset(%Status{}, %{name: "评阅拒绝"}) |> Repo.insert!



# Add Papers
# Paper record not added because file is invalid
# docx may run into zip
# backend = Exfile.Config.get_backend("store")
# {:ok, file} = Exfile.Backend.upload(backend, %Exfile.LocalFile{path: "/Users/loongmxbt/Documents/elec-market.pdf"})
#
# Repo.delete_all Paper
# Paper.changeset(%Paper{}, %{title: "热力学第一定律管理员", topic_id: 1, user_id: 1, file: file})
# |> Repo.insert!
#
# Paper.changeset(%Paper{}, %{title: "热力学第二定律万有引力", topic_id: 3, user_id: 5, file: file})
# |> Repo.insert!
#
# Paper.changeset(%Paper{}, %{title: "热力学第三定律空调制冷", topic_id: 2, user_id: 6, file: file})
# |> Repo.insert!

# Add reviews
# Repo.delete_all Review
# Review.changeset(%Review{}, %{status_id: 1, paper_id: 1, user_id: 2})
# |> Repo.insert!
# Review.changeset(%Review{}, %{status_id: 1, paper_id: 1, user_id: 3})
# |> Repo.insert!
# Review.changeset(%Review{}, %{status_id: 1, paper_id: 1, user_id: 4})
# |> Repo.insert!
# Review.changeset(%Review{}, %{status_id: 1, paper_id: 2, user_id: 2})
# |> Repo.insert!
# Review.changeset(%Review{}, %{status_id: 1, paper_id: 2, user_id: 3})
# |> Repo.insert!

# Posts
Repo.delete_all Post
Post.changeset(%Post{}, %{title: "会议投稿截止日期延长至6月30日", content: "会议投稿截止日期延长至6月30日"})
|> Repo.insert!
Post.changeset(%Post{}, %{title: "2016中国工程热物理学会燃烧学学术年会通知（PDF文档下载）", content: "2016中国工程热物理学会燃烧学学术年会通知（PDF文档下载）"})
|> Repo.insert!
Post.changeset(%Post{}, %{title: "Call for papers (for foreign attendees)（PDF Version）", content: "Call for papers (for foreign attendees)（PDF Version）"})
|> Repo.insert!

# Info
Repo.delete_all Info

Info.changeset(%Info{}, %{name: "举办地址", slug: "address", content: "华北电力大学"})
|> Repo.insert!
Info.changeset(%Info{}, %{name: "联系电话", slug: "phone", content: "010-88888888"})
|> Repo.insert!
Info.changeset(%Info{}, %{name: "官方邮箱", slug: "email", content: "admin@thermophysics.cn"})
|> Repo.insert!
Info.changeset(%Info{}, %{name: "微信公众号", slug: "wechat", content: "http://placehold.it/150x150"})
|> Repo.insert!
Info.changeset(%Info{}, %{name: "主标题", slug: "header_h1", content: "2016 中国工程热物理学会·工程热物理学术年会"})
|> Repo.insert!
Info.changeset(%Info{}, %{name: "次标题", slug: "header_h2", content: "2016年10月21-23日 | 北京·华北电力大学"})
|> Repo.insert!
Info.changeset(%Info{}, %{name: "菜单标题", slug: "header_logo", content: "CNETD2016"})
|> Repo.insert!
Info.changeset(%Info{}, %{name: "顶部背景图", slug: "header_bg", content: "/images/header-bg.jpg"})
|> Repo.insert!
Info.changeset(%Info{}, %{name: "欢迎图片", slug: "welcome_img", content: "http://clbs.escience.cn/doc/56e8ee73e4b07669127ddb6f.jpg"})
|> Repo.insert!
Info.changeset(%Info{}, %{name: "主办单位-中国工程热物理学会", slug: "host1", content: "/images/中国工程热物理学会.png"})
|> Repo.insert!
Info.changeset(%Info{}, %{name: "主办单位-国家自然科学基金委", slug: "host2", content: "/images/国家自然科学基金委.png"})
|> Repo.insert!
Info.changeset(%Info{}, %{name: "承办单位-广东工业大学", slug: "partner1", content: "/images/广东工业大学.png"})
|> Repo.insert!
Info.changeset(%Info{}, %{name: "承办单位-中科院广州能源所", slug: "partner2", content: "/images/中科院广州能源所.jpg"})
|> Repo.insert!
Info.changeset(%Info{}, %{name: "提交论文", slug: "paper_submit", content: "<li>初稿终稿请于同一篇文章提交！</li><li>提交终稿请选择初稿进行编辑重新上传！</li>"})
|> Repo.insert!
Info.changeset(%Info{}, %{name: "论文类型（初稿/终稿）", slug: "paper_type", content: "初稿"})
|> Repo.insert!
