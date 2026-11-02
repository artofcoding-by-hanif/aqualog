import 'package:flutter/material.dart';

import 'aqua_page_route.dart';

// Import screens
import '../features/app/presentation/onboarding/onboarding_screen.dart';
import '../features/app/presentation/settings/settings_screen.dart';
import '../features/tank/domain/entities/tank.dart';
import '../features/tank/presentation/screens/tank_detail_screen.dart';
import '../features/tank/presentation/screens/tank_gallery_screen.dart';
import '../features/tank/presentation/screens/tank_list_screen.dart';
import '../features/tank/presentation/screens/tank_form_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/reminders/domain/entities/reminder.dart';
import '../features/reminders/presentation/reminder_list_screen.dart';
import '../features/reminders/presentation/reminder_form_screen.dart';
import '../features/logs/presentation/log_list_screen.dart';
import '../features/knowledge/presentation/knowledge_list_screen.dart';
import '../features/equipment/filtration/domain/entities/filter.dart';
import '../features/equipment/filtration/presentation/screens/filter_list_screen.dart';
import '../features/equipment/filtration/presentation/screens/filter_detail_screen.dart';
import '../features/equipment/filtration/presentation/filter_form.dart';
import '../features/equipment/lighting/domain/entities/lighting.dart';
import '../features/equipment/lighting/presentation/screens/lighting_list_screen.dart';
import '../features/equipment/lighting/presentation/screens/lighting_detail_screen.dart';
import '../features/equipment/lighting/presentation/lighting_form.dart';
import '../features/livestock/fish/domain/entities/fish.dart';
import '../features/livestock/fish/presentation/screens/fish_list_screen.dart';
import '../features/livestock/fish/presentation/screens/fish_detail_screen.dart';
import '../features/livestock/fish/presentation/fish_form.dart';
import '../features/livestock/invertebrates/domain/entities/invertebrate.dart';
import '../features/livestock/invertebrates/presentation/screens/invertebrate_list_screen.dart';
import '../features/livestock/invertebrates/presentation/screens/invertebrate_detail_screen.dart';
import '../features/livestock/invertebrates/presentation/invertebrate_form.dart';
import '../features/hardscape/domain/entities/rock.dart';
import '../features/hardscape/domain/entities/driftwood.dart';
import '../features/hardscape/presentation/screens/rock_list_screen.dart';
import '../features/hardscape/presentation/screens/rock_detail_screen.dart';
import '../features/hardscape/presentation/rock_form.dart';
import '../features/hardscape/presentation/screens/driftwood_list_screen.dart';
import '../features/hardscape/presentation/screens/driftwood_detail_screen.dart';
import '../features/hardscape/presentation/driftwood_form.dart';
import '../features/substrate/presentation/substrate_editor.dart';
import '../features/logs/domain/entities/maintenance_log.dart';
import '../features/logs/domain/entities/feeding_log.dart';
import '../features/logs/presentation/screens/maintenance_log_list_screen.dart';
import '../features/logs/presentation/screens/maintenance_log_form_screen.dart';
import '../features/logs/presentation/screens/feeding_log_list_screen.dart';
import '../features/logs/presentation/screens/feeding_log_form_screen.dart';
import '../features/logs/presentation/screens/tank_timeline_screen.dart';
import '../features/water_parameters/domain/entities/water_parameter_log.dart';
import '../features/water_parameters/presentation/screens/water_parameter_log_list_screen.dart';
import '../features/water_parameters/presentation/screens/water_parameter_log_form_screen.dart';
import '../features/plants/domain/entities/plant.dart';
import '../features/plants/presentation/screens/plant_list_screen.dart';
import '../features/plants/presentation/screens/plant_detail_screen.dart';
import '../features/plants/presentation/plant_form.dart';
import '../features/glass_calculator/presentation/screens/glass_calculator_screen.dart';
import '../features/glass_calculator/presentation/screens/saved_glass_calculations_screen.dart';
import '../features/filter_calculator/presentation/screens/filter_calculator_screen.dart';
import '../features/ai/presentation/screens/ai_chat_screen.dart';
import '../features/ai/presentation/screens/tank_health_screen.dart';
import '../features/subscription/presentation/tank_limit_gate.dart';

/// App router for navigation

class AppRouter {
  static const String onboarding = '/onboarding';
  static const String dashboard = '/dashboard';
  static const String tankList = '/tanks';
  static const String tankDetail = '/tanks/detail';
  static const String tankForm = '/tanks/form';
  static const String settings = '/settings';
  static const String reminders = '/reminders';
  static const String logs = '/logs';
  static const String knowledge = '/knowledge';
  static const String filterList = '/filters';
  static const String filterDetail = '/filters/detail';
  static const String filterForm = '/filters/form';
  static const String lightingList = '/lightings';
  static const String lightingDetail = '/lightings/detail';
  static const String lightingForm = '/lightings/form';
  static const String fishList = '/fish';
  static const String fishDetail = '/fish/detail';
  static const String fishForm = '/fish/form';
  static const String invertebrateList = '/invertebrates';
  static const String invertebrateDetail = '/invertebrates/detail';
  static const String invertebrateForm = '/invertebrates/form';
  static const String rockList = '/rocks';
  static const String rockDetail = '/rocks/detail';
  static const String rockForm = '/rocks/form';
  static const String driftwoodList = '/driftwoods';
  static const String driftwoodDetail = '/driftwoods/detail';
  static const String driftwoodForm = '/driftwoods/form';
  static const String substrateEditor = '/substrate';
  static const String reminderForm = '/reminders/form';
  static const String maintenanceLogList = '/logs/maintenance';
  static const String maintenanceLogForm = '/logs/maintenance/form';
  static const String feedingLogList = '/logs/feeding';
  static const String feedingLogForm = '/logs/feeding/form';
  static const String waterParameterLogList = '/parameters';
  static const String waterParameterLogForm = '/parameters/form';
  static const String tankTimeline = '/tanks/timeline';
  static const String tankGallery = '/tanks/gallery';
  static const String plantList = '/plants';
  static const String plantDetail = '/plants/detail';
  static const String plantForm = '/plants/form';
  static const String glassCalculator = '/glass-calculator';
  static const String savedGlassCalculations = '/glass-calculator/saved';
  static const String filterCalculator = '/filter-calculator';
  static const String aiChat = '/ai/chat';
  static const String tankHealth = '/ai/health';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case aiChat:
        final args = settings.arguments as Map<String, dynamic>?;
        return AquaPageRoute(
          builder: (_) => AiChatScreen(
            tankId: args?['tankId'] as int?,
            tankName: args?['tankName'] as String?,
          ),
        );
      case tankHealth:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => TankHealthScreen(
            tankId: args['tankId'] as int,
            tankName: args['tankName'] as String,
          ),
        );
      case onboarding:
        return AquaPageRoute(builder: (_) => const OnboardingScreen());
      case dashboard:
        return AquaPageRoute(builder: (_) => const DashboardScreen());
      case tankList:
        return AquaPageRoute(builder: (_) => const TankListScreen());
      case tankDetail:
        final tank = settings.arguments as TankEntity;
        return AquaPageRoute(builder: (_) => TankDetailScreen(tank: tank));
      case tankForm:
        final tank = settings.arguments as TankEntity?;
        return AquaPageRoute(
          builder: (_) => tank == null
              // New tanks count against the free plan's limit
              ? const TankLimitGate(child: TankFormScreen())
              : TankFormScreen(tank: tank),
        );
      case AppRouter.settings:
        return AquaPageRoute(builder: (_) => const SettingsScreen());
      case reminders:
        return AquaPageRoute(builder: (_) => const ReminderListScreen());
      case logs:
        return AquaPageRoute(builder: (_) => const LogListScreen());
      case knowledge:
        return AquaPageRoute(builder: (_) => const KnowledgeListScreen());
      case filterList:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => FilterListScreen(
            tankId: args['tankId'] as int,
            tankName: args['tankName'] as String,
          ),
        );
      case filterDetail:
        final filter = settings.arguments as FilterEntity;
        return AquaPageRoute(
          builder: (_) => FilterDetailScreen(filter: filter),
        );
      case filterForm:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => FilterFormScreen(
            tankId: args['tankId'] as int,
            filter: args['filter'] as FilterEntity?,
          ),
        );
      case lightingList:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => LightingListScreen(
            tankId: args['tankId'] as int,
            tankName: args['tankName'] as String,
          ),
        );
      case lightingDetail:
        final lighting = settings.arguments as LightingEntity;
        return AquaPageRoute(
          builder: (_) => LightingDetailScreen(lighting: lighting),
        );
      case lightingForm:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => LightingFormScreen(
            tankId: args['tankId'] as int,
            tankName: args['tankName'] as String?,
            lighting: args['lighting'] as LightingEntity?,
          ),
        );
      case fishList:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => FishListScreen(
            tankId: args['tankId'] as int,
            tankName: args['tankName'] as String,
          ),
        );
      case fishDetail:
        final fish = settings.arguments as FishEntity;
        return AquaPageRoute(builder: (_) => FishDetailScreen(fish: fish));
      case fishForm:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => FishFormScreen(
            tankId: args['tankId'] as int,
            fish: args['fish'] as FishEntity?,
          ),
        );
      case invertebrateList:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => InvertebrateListScreen(
            tankId: args['tankId'] as int,
            tankName: args['tankName'] as String,
          ),
        );
      case invertebrateDetail:
        final invertebrate = settings.arguments as InvertebrateEntity;
        return AquaPageRoute(
          builder: (_) => InvertebrateDetailScreen(invertebrate: invertebrate),
        );
      case invertebrateForm:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => InvertebrateFormScreen(
            tankId: args['tankId'] as int,
            invertebrate: args['invertebrate'] as InvertebrateEntity?,
          ),
        );
      case rockList:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => RockListScreen(
            tankId: args['tankId'] as int,
            tankName: args['tankName'] as String,
          ),
        );
      case rockDetail:
        final rock = settings.arguments as RockEntity;
        return AquaPageRoute(builder: (_) => RockDetailScreen(rock: rock));
      case rockForm:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => RockFormScreen(
            tankId: args['tankId'] as int,
            rock: args['rock'] as RockEntity?,
          ),
        );
      case driftwoodList:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => DriftwoodListScreen(
            tankId: args['tankId'] as int,
            tankName: args['tankName'] as String,
          ),
        );
      case driftwoodDetail:
        final driftwood = settings.arguments as DriftwoodEntity;
        return AquaPageRoute(
          builder: (_) => DriftwoodDetailScreen(driftwood: driftwood),
        );
      case driftwoodForm:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => DriftwoodFormScreen(
            tankId: args['tankId'] as int,
            driftwood: args['driftwood'] as DriftwoodEntity?,
          ),
        );
      case substrateEditor:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => SubstrateEditor(tankId: args['tankId'] as int),
        );
      case reminderForm:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => ReminderFormScreen(
            reminder: args['reminder'] as ReminderEntity?,
            tankId: args['tankId'] as int?,
          ),
        );
      case maintenanceLogList:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => MaintenanceLogListScreen(
            tankId: args['tankId'] as int,
            tankName: args['tankName'] as String,
          ),
        );
      case maintenanceLogForm:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => MaintenanceLogFormScreen(
            tankId: args['tankId'] as int,
            tankName: args['tankName'] as String,
            log: args['log'] as MaintenanceLogEntity?,
            initialType: args['initialType'] as MaintenanceType?,
          ),
        );
      case feedingLogList:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => FeedingLogListScreen(
            tankId: args['tankId'] as int,
            tankName: args['tankName'] as String,
          ),
        );
      case feedingLogForm:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => FeedingLogFormScreen(
            tankId: args['tankId'] as int,
            tankName: args['tankName'] as String,
            log: args['log'] as FeedingLogEntity?,
          ),
        );
      case waterParameterLogList:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => WaterParameterLogListScreen(
            tankId: args['tankId'] as int,
            tankName: args['tankName'] as String,
          ),
        );
      case waterParameterLogForm:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => WaterParameterLogFormScreen(
            tankId: args['tankId'] as int,
            tankName: args['tankName'] as String,
            log: args['log'] as WaterParameterLogEntity?,
          ),
        );
      case tankTimeline:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => TankTimelineScreen(
            tankId: args['tankId'] as int,
            tankName: args['tankName'] as String,
          ),
        );
      case tankGallery:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => TankGalleryScreen(
            tankId: args['tankId'] as int,
            tankName: args['tankName'] as String,
          ),
        );
      case plantList:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => PlantListScreen(
            tankId: args['tankId'] as int,
            tankName: args['tankName'] as String,
          ),
        );
      case plantDetail:
        final plant = settings.arguments as PlantEntity;
        return AquaPageRoute(builder: (_) => PlantDetailScreen(plant: plant));
      case plantForm:
        final args = settings.arguments as Map<String, dynamic>;
        return AquaPageRoute(
          builder: (_) => PlantFormScreen(
            tankId: args['tankId'] as int,
            plant: args['plant'] as PlantEntity?,
          ),
        );
      case glassCalculator:
        return AquaPageRoute(builder: (_) => const GlassCalculatorScreen());
      case savedGlassCalculations:
        return AquaPageRoute(
          builder: (_) => const SavedGlassCalculationsScreen(),
        );
      case filterCalculator:
        return AquaPageRoute(builder: (_) => const FilterCalculatorScreen());
      default:
        return AquaPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
