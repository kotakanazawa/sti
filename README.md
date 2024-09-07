# STIとは

- モデルの継承構造をリレーショナルデータベースで表現したもの
- ある親クラスから派生するサブクラスを共通の1つのテーブルに対応させること
  - そのため、テーブルの各レコードがどのクラスに属するのかを識別するためのカラムが必要になる

# RailsでのSTI

たとえば、Animalクラスを親として、Animalsテーブルを作るとする。また、サブクラスでDog、Catクラスを作る。この場合、サブクラスの各レコードを識別するために、Animalクラスに`type`カラムを用意する。

```ruby
t.string "type"
```

そして、

```ruby
> dog = Dog.create(name: 'Taro', bark_volume: 10)
  TRANSACTION (0.0ms)  begin transaction
  Dog Create (1.0ms)  INSERT INTO "animals" ("name", "type", "created_at", "updated_at", "bark_volume", "claw_sharpness") VALUES (?, ?, ?, ?, ?, ?) RETURNING "id"  [["name", "Taro"], ["type", "Dog"], ["created_at", "2024-09-07 12:12:58.896898"], ["updated_at", "2024-09-07 12:12:58.896898"], ["bark_volume", 10], ["claw_sharpness", nil]]
  TRANSACTION (0.3ms)  commit transaction
=>
```


```ruby
> dog.class
=> Dog(id: integer, name: string, type: string, created_at: datetime, updated_at: datetime, bark_volume: integer, claw_sharpness: integer)
```

```ruby
> Dog.superclass
=> Animal(id: integer, name: string, type: string, created_at: datetime, updated_at: datetime, bark_volume: integer, claw_sharpness: integer)
```

```ruby
> dog.type
=> "Dog"
```

このように、`type`には自動でそのサブクラスの名前が登録される。これで各レコードがどのモデルに所属するのか識別する。

# STIのメリット

- コードの再利用性が高い
  - 共通のメソッドやバリデーションを親クラスに記述し、サブクラスごとに異なる振る舞いをもたせられる
- 1つのテーブルで複数モデルを管理できるためシンプル

# STIの問題点

ひとつのサブクラスにのみ適応させたい属性がある場合、他のサブクラスではそれが常にnilになる。また、その属性にNOT NULL制約をつけられない。今回の場合だと、Catクラスで`bark_volume`は必ずnilになるし、`claw_sharpness`はDogクラスで必ずnilになる。

```ruby
ActiveRecord::Schema[7.2].define(version: 2024_09_07_115051) do
  create_table "animals", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bark_volume"
    t.integer "claw_sharpness"
  end
end
```

これがチリツモで増えていくことで、整合性の取れないデータが増える恐れがある。
