const String fetchMezmursQuery = r'''
query fetchAllMezmurs {
  finote_mezmur {
    id
    title
    isShortSong
    lyrics
    Angel
    Holidays
    K_Gebriel_Song
    St_Mary_Song
    Trinity_Song
    audio_link
    genre
    mezmur_ref_number
    singer_id
    special
    youtube_link
    isRepentanceSong
  }
}
''';

const String trinityHamleQuery = r'''
query fetchAllMezmurs {
  finote_mezmur(where: {Trinity_Song: {_contains: "ሐምሌ"}}) {
    id
    title
    isShortSong
    lyric {
      chorus
      id
      translation
      verse
    }
    Angel
    Holidays
    K_Gebriel_Song
    St_Mary_Song
    Trinity_Song
    audio_link
    genre
    mezmur_ref_number
    singer{
      id
      name
    }
    special
    youtube_link
    isRepentanceSong
  }
}
''';


