Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
  },

  events: {
    'click .poke-info': 'selectPokemonFromList'
  },
  addPokemonToList: function (pokemon) {
        var content = JST["pokemonListItem"]({"pokemon": pokemon});
        this.$el.append(content);
  },

  refreshPokemon: function (options) {
    this.collection.fetch({
      success: (function () {
        this.render();
        //options.success is a success callback function in the options hash
        //if it is there, check that it is there
        //if the check (first part of &&) is true execute the next part of the &&
        options.success && options.success();
      }).bind(this)
    });
  },

  render: function () {
    this.$el.empty();
    this.collection.each(function(pokemon){
      this.addPokemonToList(pokemon)
    }.bind(this));

    return this;
  },

  selectPokemonFromList: function (event) {
    var pokeId = $(event.currentTarget).data('id');
    var pokemon = this.collection.get(pokeId);

    Backbone.history.navigate("/pokemon/" + pokeId, {trigger: true});
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click li.toy-list-item": "selectToyFromList"
  },

  refreshPokemon: function (options) {
    var that = this;

    this.model.fetch({
      success: function(){
        that.render();
      }
    })
  },

  render: function () {
    this.$el.empty();
    var content = JST["pokemonDetail"]({'pokemon': this.model});
    this.$el.append(content);

    var that = this;
    this.model.toys().each(function(toy){
      var toyContent = JST["toyListItem"]({'toy': toy});
      that.$el.append(toyContent);
    });
  },

  selectToyFromList: function (event) {
    var pokeId = this.model.get('id');
    var toyId = $(event.currentTarget).data("id");

    Backbone.history.navigate("/pokemon/" + pokeId + "/toys/" + toyId, {trigger: true})
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    var pokes = null;
    var content = JST["toyDetail"]({'toy': this.model, 'pokes': pokes})
    this.$el.append(content);
  }
});


// $(function () {
//   var pokemonIndex = new Pokedex.Views.PokemonIndex();
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });
