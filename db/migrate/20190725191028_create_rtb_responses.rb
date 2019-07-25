class CreateRtbResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :rtb_responses do |t|
    	t.string :bidid
    	t.string :cur
    	t.string :main_id
    	t.jsonb :seatbid
      t.timestamps
    end
  end
end
