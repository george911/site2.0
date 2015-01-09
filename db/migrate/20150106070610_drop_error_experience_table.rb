class DropErrorExperienceTable < ActiveRecord::Migration
  def change
    drop_table :experiences;
  end
end
