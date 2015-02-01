TrelloClone.Collections.Items = Backbone.Collection.extend({
  urlRoot: "api/items",
  model: TrelloClone.Models.Item
});
