# frozen_string_literal: true

God.create!([
              { name: 'Zeus' },
              { name: 'Hēra' },
              { name: 'Athēnā' },
              { name: 'Apollōn' },
              { name: 'Aphrodītē' },
              { name: 'Arēs' },
              { name: 'Artemis' },
              { name: 'Dēmētēr' },
              { name: 'Hēphaistos' },
              { name: 'Hermēs' },
              { name: 'Poseidōn' },
              { name: 'Hestiā' },
              { name: 'Dionȳsos' },
              { name: 'Hādēs' },
              { name: 'Persephonē' },
              { name: 'Rheā' }
            ])

Edge.create!([
               { comment: '', cost: 0, directed: true, destination_type: 'God', destination_id: 2, departure_type: 'God',
                 departure_id: 1 },
               { comment: '', cost: 0, directed: true, destination_type: 'God', destination_id: 6, departure_type: 'God',
                 departure_id: 2 },
               { comment: '', cost: 0, directed: true, destination_type: 'God', destination_id: 9, departure_type: 'God',
                 departure_id: 2 },
               { comment: '', cost: 0, directed: true, destination_type: 'God', destination_id: 1, departure_type: 'God',
                 departure_id: 16 },
               { comment: '', cost: 0, directed: true, destination_type: 'God', destination_id: 12, departure_type: 'God',
                 departure_id: 16 },
               { comment: '', cost: 0, directed: true, destination_type: 'God', destination_id: 14, departure_type: 'God',
                 departure_id: 16 },
               { comment: '', cost: 0, directed: true, destination_type: 'God', destination_id: 2, departure_type: 'God',
                 departure_id: 16 },
               { comment: '', cost: 0, directed: true, destination_type: 'God', destination_id: 11, departure_type: 'God',
                 departure_id: 16 },
               { comment: '', cost: 0, directed: true, destination_type: 'God', destination_id: 8, departure_type: 'God',
                 departure_id: 16 },
               { comment: '', cost: 0, directed: true, destination_type: 'God', destination_id: 15, departure_type: 'God',
                 departure_id: 14 }
             ])
