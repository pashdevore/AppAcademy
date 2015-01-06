a = User.create!(:username => "jack")
b = User.create!(:username => "jill")
c = User.create!(:username => "hill")

contact1 = Contact.create!(:name => "Jack", :email => "jack@gmail.com", :user_id => a.id)
contact2 = Contact.create!(:name => "Jill", :email => "jill@gmail.com", :user_id => b.id)
contact3 = Contact.create!(:name => "Hill", :email => "hill@gmail.com", :user_id => c.id)

ContactShare.create!(:contact_id => contact2.id, :user_id => a.id)
ContactShare.create!(:contact_id => contact3.id, :user_id => a.id)

Comment.create!(user_id: a.id, commentable_id: b.id, commentable_type: b.class.to_s, text: "You're hot!")
Comment.create!(user_id: a.id, commentable_id: contact2.id, commentable_type: contact2.class.to_s, text: "Nice. I use gmail too!")
