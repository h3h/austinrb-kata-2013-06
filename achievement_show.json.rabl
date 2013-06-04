attributes :id, :name, :created_at
child :users => :users do
  attributes :id, :email, :created_at
end
