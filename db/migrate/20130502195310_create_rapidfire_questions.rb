class CreateRapidfireQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :rapidfire_questions do |t|
      t.references :survey
      t.string  :type
      t.string  :question_text
      t.string  :default_text
      t.string  :placeholder
      t.integer :position
      t.text :answer_options
      t.text :validation_rules

      t.timestamps
    end
  end
end
