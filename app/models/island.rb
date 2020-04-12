class Island < ActiveHash::Base
  self.data = [
      {id: 1, name: '宮古島'}, {id: 2, name: '池間島'}, {id: 3, name: '来間島'},
      {id: 4, name: '伊良部島'}, {id: 5, name: '下地島'}
  ]
end