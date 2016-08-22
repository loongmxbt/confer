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
|> Repo.insert! |> Coherence.ControllerHelpers.confirm!

User.changeset(%User{}, %{name: "phoenixfbi", email: "phoenixfbi@163.com", password: "fbi555", password_confirmation: "fbi555", role_id: 1})
|> Repo.insert! |> Coherence.ControllerHelpers.confirm!

for i <- 1..5 do
  User.changeset(%User{}, %{name: "用户#{i}", email: "user#{i}@163.com", password: "user555", password_confirmation: "user555", role_id: 1})
  |> Repo.insert! |> Coherence.ControllerHelpers.confirm!
end

for i <- 1..20 do
  User.changeset(%User{}, %{name: "教授#{i}", email: "prof#{i}@163.com", password: "prof555", password_confirmation: "prof555", role_id: 2, topic_id: rem(i, 5)+1 })
  |> Repo.insert! |> Coherence.ControllerHelpers.confirm!
end



# Add pages
welcome_text = "<p>
  伴随着火的使用，人类文明逐渐走出黑暗，迈向光明。燃烧渗透在人们日常生活的各个方面，人类对燃烧的探索也从未停止。燃烧学的发展进步，为解决能源和环境危机、开展火灾防治等提供了重要的理论指导，也为人类在能源、环境、火灾、国防及空间探索等诸多领域中的活动提供了科学依据。
</p>
<p>
  随着国家自然科学基金委和其它基础研究项目的持续投入，我国在燃烧学领域的研究取得了长足进展，解决了众多科学难题。我国燃烧界具有国际影响力的专家学者队伍也在不断壮大，我国学者在国际燃烧领域权威期刊《Combustion and Flame》和《Proceedings of the Combustion Institute》上发表的论文数居世界第二位，为国际燃烧学的发展进步做出了卓越贡献。
</p>
<p>
  根据中国工程热物理学会燃烧学专业委员会的安排，2016年中国工程热物理学会燃烧学学术年会将于2016年10月21-23日在安徽马鞍山举行。会议将围绕燃烧特性与层流火焰，化学反应动力学，湍流火焰和燃烧过程的数值分析，喷雾与液滴燃烧，燃烧测试与诊断技术，爆轰、爆炸和超音速燃烧，火灾科学与技术，燃烧污染物控制，煤和生物质的燃烧与气化，内燃机和燃气轮机燃烧，新型燃烧技术等11个专题开展交流，旨在展示我国燃烧领域学者的新成果，碰撞出燃烧研究的新火花，挑战遇到的新问题。大会由国家自然科学基金委工程与材料科学部工程科学三处和中国工程热物理学会燃烧学分会主办，安徽工业大学承办。会议将由大会邀请报告、专题报告、基金进展报告以及各专题的分组报告构成。
</p>"

Repo.delete_all Page
Page.changeset(%Page{}, %{title: "组委会致欢迎辞", slug: "welcome", content: welcome_text})
|> Repo.insert!

Page.changeset(%Page{}, %{title: "组织结构", slug: "organization", content: "content here"})
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
backend = Exfile.Config.get_backend("store")
{:ok, file} = Exfile.Backend.upload(backend, %Exfile.LocalFile{path: "/Users/loongmxbt/Documents/elec-market.pdf"})

Repo.delete_all Paper
Paper.changeset(%Paper{}, %{title: "热力学第一定律管理员", topic_id: 1, user_id: 1, file: file})
|> Repo.insert!

Paper.changeset(%Paper{}, %{title: "热力学第二定律万有引力", topic_id: 3, user_id: 5, file: file})
|> Repo.insert!

Paper.changeset(%Paper{}, %{title: "热力学第三定律空调制冷", topic_id: 2, user_id: 6, file: file})
|> Repo.insert!

# Add reviews
Repo.delete_all Review
Review.changeset(%Review{}, %{status_id: 1, paper_id: 1, user_id: 2})
|> Repo.insert!
Review.changeset(%Review{}, %{status_id: 1, paper_id: 1, user_id: 3})
|> Repo.insert!
Review.changeset(%Review{}, %{status_id: 1, paper_id: 1, user_id: 4})
|> Repo.insert!
Review.changeset(%Review{}, %{status_id: 1, paper_id: 2, user_id: 2})
|> Repo.insert!
Review.changeset(%Review{}, %{status_id: 1, paper_id: 2, user_id: 3})
|> Repo.insert!

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
