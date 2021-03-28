class AddSchemaOrgRoleToWorkTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :work_types, :schema_org_role, :string
  end
end
