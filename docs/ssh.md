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
