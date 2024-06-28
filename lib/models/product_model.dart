class ProductModel {
  double price;
  String path;
  String details;
  String title;

  ProductModel(
      {required this.path,
      required this.price,
      required this.details,
      required this.title});
}

final List<ProductModel> listOfData = [
  ProductModel(
      path: 'assets/images/lap#1.png',
      price: 1249,
      title: "Asus ROG Zephyrus G14 - Best overall",
      details:
          "The ROG Zephyrus G14 is both lightweight and powerful. It weighs just a little over three pounds, which makes it a capable traveling laptop. Thanks to the AMD Ryzen 9 6900HS processor and AMD Radeon RX6800S GPU, you can expect strong performance as well. The only weakness is the keyboard, which our tester describes as “meh.” It feels a little mushy and the backlighting is rather unimpressive. Nitpicks aside, the Zephyrus G14 is well worth it. In addition to the strong performance, the 1600p display produces vibrant images and the audio is decent. If you’re in the market for a portable Asus laptop that delivers zippy performance, this laptop is a phenomenal pick."),
  ProductModel(
      path: 'assets/images/lap#2.png',
      price: 1049,
      title: 'Asus VivoBook Pro 15 OLED Ultra Slim Laptop',
      details:
          "Back in the days of old, laptops with OLED displays were something of a far-fetched dream. Nowadays, they’re more mainstream and the Asus VivoBook Pro 15 is one such example. According to our review, the Pro 15 has an “outstanding 15.6-inch 1080p OLED non-touch display at an affordable price.” Wild, right? Shadows are deep and wonderfully rich while brighter spots are super vivid. The color performance is fantastic as well. If you’re looking for a laptop that makes games look great and also satisfies productivity needs, the Pro 15 is a great choice."),
  ProductModel(
      path: 'assets/images/lap#3.png',
      price: 3889,
      title: "Asus ROG Zephyrus S17",
      details:
          "he Asus ROG Zephyrus S17 is a gamer’s ultimate dream. This laptop features lightning-fast GPU and CPU performance plus a stunning 17.3-inch 4K display with a 120Hz refresh rate. The rugged all-metal chassis, six speaker sound system, and customizable keyboard really adds to the premium experience as well. However, you’re going to pay out the nose for it. If you’ve got a flexible budget and you won’t settle for anything other than the best of the best, the Zephyrus S17 is truly the bees knees."),
  ProductModel(
    path: 'assets/images/lap#4.png',
    price: 1359,
    title: "Asus ROG Strix G15 Advantage Edition",
    details:
        "Granted, the premium Asus ROG Zephyrus S17 can be out of range for many people’s budgets. Coming in at a more palatable price point is the Asus ROG Strix G15 Advanced Edition, another all-AMD laptop that delivers fast CPU and GPU performance without busting your wallet. It’s packing an AMD Ryzen 5900HX processor, an AMD Radeon RX 6800M GPU (comparable to an RTX 3070 or 3080), 16GB of RAM, and 512GB of SSD storage. According to our review, the GPU “doesn’t outpace higher-wattage RTX 3080 laptop GPUs, but it’s a worthy competitor for conventional gaming tasks.” Unsurprisingly, the Strix G15 is one chunky machine, measuring 28mm at its thickest part. Although the additional thickness allows more space for cooling components, it’s not very portable. But, as long as you don’t plan on taking this laptop everywhere you go, it’s a powerful gaming rig that’s well worth the money.",
  ),
  ProductModel(
    path: 'assets/images/lap#5.png',
    price: 1399,
    title: 'Asus Zenbook S 13 OLED',
    details:
        "Thin-and-light laptops have come a long way in recent years and the Asus Zenbook 13 S OLED is a perfect example of how increased portability doesn’t have to mean decreased performance. It features the latest Intel Core i7-1355U 10-core processor, 32GB of RAM, a 1TB SSD for storage, and a gorgeous OLED screen. That’s a lot to pack into a laptop that is less than half-an-inch thick and weighs a featherlight 2.2 pounds.The Zenbook 13 S also sports a solid, mostly metal design with little flex or wobble, which is a huge plus considering how slim it is—even the thin OLED display feels sturdy. Plus, in such a svelte frame, Asus was able to fit a decent and useful selection of ports. Really, the only downside is that it has a bit of an antiquated trackpad, which makes a distinct clicking sound when you use it. Competitor laptops with similar performance features retail for quite a bit more than the Zenbook 13 S, which makes this a no-brainer if you’re in the market for an ultraportable.",
  ),
  ProductModel(
    path: 'assets/images/lap#6.png',
    price: 1199,
    title: 'Asus ROG Flow Z13 GZ301',
    details:
        "f versatility and portability are your bag, the Asus ROG Flow Z13 is a worthy option. With its detachable keyboard, you can easily convert the Flow Z13 from a 3-pound ultraportable clamshell into a 2.6-pound tablet. In both instances you’ll benefit from the the Z13’s bright, crisp 1920×1200 IPS touch display. It’s Core i9-12900H CPU and GeForce RTX 3050 Ti graphics make it suitable for gaming, though you’d probably want to invest in an external keyboard and mouse for the best experience. It’s a unique combination of qualities that’s admittedly not for everyone, but if you’re looking for maximum flexibility, it’s a capable performer, albeit at a premium price.",
  ),
  ProductModel(
    path: 'assets/images/lap#7.png',
    price: 2100,
    title: 'Asus Zenbook Pro 14 Duo OLED ',
    details:
        "Not surprisingly, the Zenbook Pro 14 Duo takes the place of its predecessor as the best Asus laptop for content creation, and it does so with thoughtful improvements that make it an even better product. What makes this laptop uniquely suitable for content creators is its dual-display design, and in this latest model, both screens get an upgrade: The 14.5-inch primary screen is a taller, brighter 120Hz OLED; the 12.7-inch secondary ScreenPad Plus, which sits just above the keyboard, is now tilted at more of an angle for better visibility. Together they enable more flexible work organization and multi-tasking.Add to that 12th-gen Intel CPUs and up to an Nvidia RTX 3050 Ti GPU, a large and comfortable keyboard, generous port selection, and a stylish look, and you can see why we recommend this Asus laptop in particular is ideal for creators.",
  ),
];
