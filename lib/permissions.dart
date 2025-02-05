
enum UserRole {
  superAdmin,
  admin,
  normalUser,
}

// This is a helper class that contains the rules.
class RolePermissions {
  // This map lists what each role can do.
  static final Map<UserRole, List<String>> permissions = {
    UserRole.superAdmin: [
      "manage_users",
      "view_analytics",
      "manage_groups",
      "toggle_permissions",
      "edit_all",
    ],
    UserRole.admin: [
      "manage_group_members",
      "view_group_analytics",
      "add_events",
      "edit_own_group",
    ],
    UserRole.normalUser: [
      "view_events",
      "update_profile",
    ],
  };

  // This function checks if a role is allowed to do something.
  static bool hasPermission(UserRole role, String permission) {
    // Look in our map and check if the role's list contains the permission.
    return permissions[role]?.contains(permission) ?? false;
  }
}
