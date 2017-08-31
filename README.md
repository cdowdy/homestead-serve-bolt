A Bolt CMS Site type for [Laravel Homestead](https://laravel.com/docs/5.5/homestead)  

  
  
 Laravel Homestead allows you to "map sites" and create a custom Nginx Server configuration. You can use the Symfony4 Template but you may run into some quirks.  
 
 So I've made this one really quickly and added in [bolt's nginx server configuration](https://docs.bolt.cm/3.3/installation/webserver/nginx#)  
 
 ## Usage  
 
 Add this script (serve-bolt.sh) to the "scripts" directory of your homestead install/directory
 
 Edit the  ``Homestead.yml`` file "sites" portion to point to your local Bolt install, and add a type of "bolt" like so:  
 
 ```yaml  
 ---
ip: "192.168.10.10"
memory: 2048
cpus: 1
provider: virtualbox

authorize: ~/.ssh/id_rsa.pub

keys:
    - ~/.ssh/id_rsa

folders:
    - map: ~/Code
      to: /home/vagrant/Code
    # Windows Version
    - map: C:/Sites
      to: /home/vagrant/Code

sites:
    - map: my-bolt-site.dev
      to: /home/vagrant/Code/your-bolt-install-directory-name/public
      type: bolt
    # so if your local bolt install is called "bolt" it'll look as follows:
    - map: myboltsite.dev
      to: /home/vagarant/Code/bolt/public
      type: bolt

databases: 
    - homestead
 ```  
 
 Once all that is setup you can then run `vagrant up`` or `` vagrant provision`` or ``vagrant up --provision`` 
 
