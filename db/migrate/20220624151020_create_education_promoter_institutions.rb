class CreateEducationPromoterInstitutions < ActiveRecord::Migration[7.0]
  def change
    create_table :education_promoter_institutions do |t|
      t.references :education, null: false, foreign_key: true
      t.references :promoter_institution, null: false, foreign_key: { to_table: :organizations }, index: { name: "index_edu_promo_inst_on_promoter_institution_id" }

      t.timestamps
    end
  end
end
