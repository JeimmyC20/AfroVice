import { Music4, Instagram } from 'lucide-react';

export default function ArtistsPage() {
  const artists = [
    {
      name: 'Kapo',
      genre: 'Afro',
      image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvpqMlohm9XNvEE2DkqxWMNHzGxD6zfO_BbmzHEv1EqWrfktvjaQDWpxNisM43uRYQzvAt7kGW6CautYFCdBd6OlWjmmuAr_lrTRPKww&s=10',
      bio: 'El mejor compositor colombiano de los géneros Afrobeat y reguetón.',
      instagram: 'https://www.instagram.com/yosoytukapo/?hl=es-la',
    },
    {
      name: 'Asake',
      genre: 'Afro',
      image: 'https://www.billboard.com/wp-content/uploads/2023/06/Asake-cr-Ola-Alabi-billboard-1548.jpg',
      bio: 'Reconocido por sus mezclas de dancehall',
      instagram: 'https://www.instagram.com/asakemusic',
    },
    {
      name: 'J Balvin',
      genre: 'Reggaetón',
      image: 'https://yt3.googleusercontent.com/UqJr0qGvZ5xpw2BMCjPEl8_oOp7Y3ttA6ZG2fJspi8jLx6e2GRLiqLjM5dtPB6Gxkc1JFTRXS3Y=s900-c-k-c0x00ffffff-no-rj',
      bio: 'Los mejores temas de reggaetón',
      instagram: 'https://www.instagram.com/jbalvin/?hl=es-la',
    },
  ];

  return (
    <div className="min-h-screen bg-[#1a0f2e] pt-24 pb-16">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="mb-12">
          <h1 className="text-4xl md:text-5xl font-bold text-white mb-4">
            Artistas
          </h1>
          <p className="text-xl text-gray-300">
            Conoce a los DJs y artistas que hacen posible cada evento
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {artists.map((artist, index) => (
            <div
              key={index}
              className="bg-white/5 rounded-2xl overflow-hidden border border-white/10 hover:border-violet-500/50 hover:bg-white/10 transition-all group"
            >
              <div className="relative h-80 overflow-hidden">
                <img
                  src={artist.image}
                  alt={artist.name}
                  className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
                />
                <div className="absolute inset-0 bg-gradient-to-t from-black/90 via-black/40 to-transparent" />
                <div className="absolute bottom-0 left-0 right-0 p-6">
                  <div className="inline-block bg-violet-600 text-white px-3 py-1 rounded-full text-xs font-semibold uppercase mb-2">
                    {artist.genre}
                  </div>
                  <h3 className="text-2xl font-bold text-white mb-2">
                    {artist.name}
                  </h3>
                  <p className="text-gray-200 text-sm">{artist.bio}</p>
                </div>
              </div>
              <div className="p-6 flex gap-3">
                <a
                  href={artist.instagram}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="flex-1 bg-white/10 hover:bg-white/20 text-white py-2 rounded-lg transition-all flex items-center justify-center gap-2"
                >
                  <Instagram className="w-4 h-4" />
                  <span className="text-sm">Instagram</span>
                </a>
              </div>
            </div>
          ))}
        </div>

        <div className="mt-16 bg-gradient-to-r from-violet-600/20 to-fuchsia-600/20 rounded-2xl p-8 md:p-12 border border-violet-500/30 text-center">
          <Music4 className="w-16 h-16 text-violet-400 mx-auto mb-4" />
          <h2 className="text-3xl font-bold text-white mb-4">¿Eres Artista?</h2>
          <p className="text-xl text-gray-200 mb-6 max-w-2xl mx-auto">
            Únete a nuestra plataforma y lleva tu música a miles de personas en
            toda Colombia
          </p>
          <button className="bg-gradient-to-r from-violet-600 to-fuchsia-600 hover:from-violet-700 hover:to-fuchsia-700 text-white px-8 py-3 rounded-full font-semibold transition-all transform hover:scale-105 shadow-lg shadow-violet-500/50">
            Contáctanos
          </button>
        </div>
      </div>
    </div>
  );
}
