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
