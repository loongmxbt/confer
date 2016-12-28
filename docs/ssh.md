ssh -p 2200 -i ~/.ssh/etd.key root@121.195.175.250
chmod 600 etd.key


sudo apt-get install postgresql
sudo passwd postgres
passwd postgres
thermophysics

su postgres
psql postgres

ALTER USER postgres with PASSWORD 'password'

ALTER USER postgres with PASSWORD 'thermophysics'


1. 登录系统
ssh -p 2200 -i ~/.ssh/etd.key root@121.195.175.250

2. 关闭正在运行的网站
ps -aux | grep elixir
以上命令获得进程号
root       4682  0.2  5.5 2197424 55440 ?       Sl   Oct20 221:21 /usr/lib/erlang/erts-8.0.2/bin/beam -- -root /usr/lib/erlang -progname erl -- -home /root -- -pa /usr/local/lib/elixir/bin/../lib/eex/ebin /usr/local/lib/elixir/bin/../lib/elixir/ebin /usr/local/lib/elixir/bin/../lib/ex_unit/ebin /usr/local/lib/elixir/bin/../lib/iex/ebin /usr/local/lib/elixir/bin/../lib/logger/ebin /usr/local/lib/elixir/bin/../lib/mix/ebin -elixir ansi_enabled true -noshell -s elixir start_cli -noshell -noinput -extra --detached -S mix do compile, phoenix.server
root     114096  0.0  0.2  11752  2168 pts/0    S+   16:30   0:00 grep --color=auto elixir
上述的第二个数字是进程id，kill它
输入 kill 4682

3. 运行网站
然后 cd /root/confer 进入到目录
MIX_ENV=prod PORT=80 elixir --detached -S mix do compile, phoenix.server
