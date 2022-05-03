# oniichan-2.0

start backend:      bin/rails server

everytime update route need to run this command: rake js:routes

rails g model User name:string password:string is_deleted:boolean
bin/rails generate controller user

bin/rails generate controller login create

rails g model UserShop name:string address:string ssm:string boss_name:string boss_phone:string user_id:bigint nick_name:string is_deleted:boolean
bin/rails generate controller userShop



bin/rails db:migrate


todo:
    UserShop isdeleted not use anymore