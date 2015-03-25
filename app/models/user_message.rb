class UserMessage < ActsAsMessageable::Message
  self.table_name = 'messages'
end