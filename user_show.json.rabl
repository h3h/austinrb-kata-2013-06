attributes :id, :email, :created_at
child :achievements => :achievements do
  attributes :id, :name, :created_at
end

