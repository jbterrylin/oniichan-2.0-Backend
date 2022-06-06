# oniichan-2.0

start backend:      bin/rails server

rails g model User name:string password:string is_deleted:boolean
bin/rails generate controller user

bin/rails generate controller login create

rails g model UserShop name:string address:string ssm:string boss_name:string boss_phone:string user_id:bigint nick_name:string is_deleted:boolean
bin/rails generate controller userShop

rails g model Item description:string unit_price:string unit:string sort_id:integer paper_id:bigint is_deleted:boolean user_id:bigint

rails g model Paper name:string user_id:bigint paper_type:string user_shop_id:bigint price_unit:string customer_id:bigint discount:string deposit:string is_deleted:boolean

rails g model Customer name:string address:string phone:string is_deleted:boolean user_id:bigint paper_id:bigint

rails g model Word cn:string en:string cat1:string cat2:string

bin/rails db:migrate

rake routes


rails db:drop:_unsafe
rails db:create db:migrate
rake db:seed

"convert(subject USING GBK)" // sort mandarin