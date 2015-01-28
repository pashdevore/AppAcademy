Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var newPoke = new Pokedex.Models.Pokemon(attrs);
  var that = this;
  newPoke.save({}, {
    success: function () {
      that.pokes.add(newPoke);
      that.addPokemonToList(newPoke);
      $(".new-pokemon").get(0).reset();
    }
  });
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  var jsObj = $(".new-pokemon").serializeJSON();
  this.createPokemon(jsObj.pokemon);
};

// Pokedex.RootView.prototype.submitPokemonForm = function (event) {
//   var attr = {};
//   attr["name"] = $("#pokemon_name").prop("pokemon[name]");
//   attr["image_url"] = $("#pokemon_image_url").prop("pokemon[image_url]");
//   attr["poke_type"] = $("#pokemon_poke_type").prop("pokemon[poke_type]");
//   attr["attack"] = $("#pokemon_attack").prop("pokemon[attack]");
//   attr["defense"] = $("#pokemon_defense").prop("pokemon[defense]");
//   moves = [];
//   moves.push($("#pokemon_move1").prop("pokemon[moves][]"))
//   moves.push($("#pokemon_move2").prop("pokemon[moves][]"))
//   attr["moves"] = moves;
//   debugger
//   this.createPokemon(attr);
// };
