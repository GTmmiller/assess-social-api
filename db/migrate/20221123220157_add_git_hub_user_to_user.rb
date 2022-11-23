class AddGitHubUserToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :github_user, :string
  end
end
