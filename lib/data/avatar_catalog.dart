/// Bundled images extracted unchanged from the user's reference component.
class AvatarOption {
  const AvatarOption(this.id, this.label, this.asset);
  final String id;
  final String label;
  final String asset;
}

const avatarOptions = [
  AvatarOption(
    'avatar_1',
    'Kacamata Merah',
    'assets/images/avatars/avatar_1.jpeg',
  ),
  AvatarOption(
    'avatar_2',
    'Kacamata Bulat',
    'assets/images/avatars/avatar_2.jpeg',
  ),
  AvatarOption(
    'avatar_3',
    'Kacamata Kotak',
    'assets/images/avatars/avatar_3.jpeg',
  ),
  AvatarOption(
    'avatar_4',
    'Rambut Samping',
    'assets/images/avatars/avatar_4.jpeg',
  ),
];

AvatarOption? findAvatar(String? id) {
  for (final option in avatarOptions) {
    if (option.id == id) return option;
  }
  return null;
}
