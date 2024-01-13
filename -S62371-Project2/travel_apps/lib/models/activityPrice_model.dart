class ActivityPriceModel {
  static Map<String, List<Activity>> activities = {
    'Malaysia': [
      Activity(
          name:
              'Explore Kuala Lumpur City Center (KLCC) and the Petronas Towers.',
          price: 25.0),
      Activity(name: 'Visit Batu Caves near Kuala Lumpur.', price: 15.0),
      Activity(name: 'Enjoy the beautiful beaches in Langkawi.', price: 20.0),
      Activity(name: 'Discover the historic city of Melaka.', price: 18.0),
      Activity(name: 'Trek through Taman Negara National Park.', price: 30.0),
      Activity(
          name: 'Experience local culture and street food in Penang.',
          price: 30.0),
      Activity(
          name:
              'Visit the Cameron Highlands for tea plantations and cool climate.',
          price: 30.0),
      Activity(
          name: 'Dive in the crystal-clear waters of Sipadan Island.',
          price: 30.0),
    ],
    'China': [
      Activity(name: 'Walk on the Great Wall of China.', price: 35.0),
      Activity(name: 'Explore the Forbidden City in Beijing.', price: 28.0),
      Activity(name: 'Cruise the Li River in Guilin.', price: 22.0),
      Activity(name: 'Visit the Terracotta Army in Xi\'an.', price: 32.0),
      Activity(
          name: 'Experience the vibrant atmosphere of Shanghai.', price: 30.0),
      Activity(
          name:
              'Hike the stunning landscapes of Zhangjiajie National Forest Park.',
          price: 32.0),
      Activity(name: 'Discover the ancient city of Pingyao.', price: 32.0),
      Activity(
          name: 'Explore the historic architecture of Suzhou.', price: 32.0),
    ],
    'India': [
      Activity(name: 'Visit the Taj Mahal in Agra.', price: 40.0),
      Activity(name: 'Explore the vibrant city of Jaipur.', price: 30.0),
      Activity(
          name: 'Experience the chaos and beauty of Varanasi.', price: 25.0),
      Activity(name: 'Discover the historic city of Delhi.', price: 22.0),
      Activity(name: 'Relax on the beaches of Goa.', price: 18.0),
      Activity(name: 'Explore the backwaters of Kerala.', price: 18.0),
      Activity(
          name:
              'Trek in the Himalayas, such as in Himachal Pradesh or Uttarakhand.',
          price: 18.0),
      Activity(name: 'Visit the ancient temples of Khajuraho.', price: 18.0),
    ],
    'Thailand': [
      Activity(name: 'Explore the bustling city of Bangkok.', price: 25.0),
      Activity(name: 'Relax on the beautiful beaches of Phuket.', price: 20.0),
      Activity(name: 'Visit the historic city of Ayutthaya.', price: 15.0),
      Activity(
          name: 'Experience the vibrant street life in Chiang Mai.',
          price: 18.0),
      Activity(
          name: 'Discover the stunning islands of Krabi Province.',
          price: 25.0),
      Activity(name: 'Explore the ancient city of Sukhothai.', price: 20.0),
      Activity(
          name: 'Visit the floating markets in Damnoen Saduak.', price: 15.0),
      Activity(name: 'Experience the nightlife in Pattaya.', price: 20.0),
    ],
    'Korea': [
      Activity(name: 'Explore the vibrant city of Seoul.', price: 30.0),
      Activity(
          name: 'Visit Gyeongbokgung Palace and Bukchon Hanok Village.',
          price: 25.0),
      Activity(
          name: 'Experience the lively atmosphere of Myeongdong.', price: 20.0),
      Activity(
          name: 'Discover the beautiful landscapes of Jeju Island.',
          price: 35.0),
      Activity(name: 'Explore the historic city of Gyeongju.', price: 22.0),
      Activity(
          name:
              'Visit the DMZ (Demilitarized Zone) on the border with North Korea.',
          price: 30.0),
      Activity(
          name:
              'Experience traditional tea culture in Boseong Green Tea Fields.',
          price: 18.0),
      Activity(
          name: 'Try Korean barbecue and street food in local markets.',
          price: 15.0),
    ],
    'Japan': [
      Activity(name: 'Explore the bustling city of Tokyo.', price: 28.0),
      Activity(
          name: 'Visit Kyoto and its historic temples and gardens.',
          price: 25.0),
      Activity(name: 'Experience the unique culture of Osaka.', price: 22.0),
      Activity(name: 'Discover the beauty of Mount Fuji.', price: 30.0),
      Activity(
          name: 'Explore the historic district of Gion in Kyoto.', price: 20.0),
      Activity(name: 'Visit the deer in Nara Park.', price: 15.0),
      Activity(
          name: 'Experience traditional tea ceremonies in Uji.', price: 18.0),
      Activity(name: 'Relax in an onsen (hot spring) in Hakone.', price: 25.0),
    ]
  };
}

class Activity {
  final String name;
  final double price;

  Activity({required this.name, required this.price});
}
