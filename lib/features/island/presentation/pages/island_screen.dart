import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/app/theme/app_colors.dart';
import 'package:fortnite_app/core/widgets/error_retry_view.dart';
import 'package:fortnite_app/core/widgets/scorebug.dart';
import 'package:fortnite_app/features/island/domain/entities/island.dart';
import 'package:fortnite_app/features/island/presentation/bloc/island_bloc.dart';

enum _IslandSection { map, modes, cosmetics, creator }

class IslandScreen extends StatefulWidget {
  const IslandScreen({super.key});

  @override
  State<IslandScreen> createState() => _IslandScreenState();
}

class _IslandScreenState extends State<IslandScreen> {
  _IslandSection _section = _IslandSection.map;
  Future<BrMap>? _mapFuture;
  Future<List<GameMode>>? _modesFuture;
  Future<List<NewCosmetic>>? _cosmeticsFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mapFuture ??= context.read<IslandBloc>().getMap();
  }

  void _select(_IslandSection section) {
    final bloc = context.read<IslandBloc>();
    setState(() {
      _section = section;
      if (section == _IslandSection.modes) {
        _modesFuture ??= bloc.getModes();
      }
      if (section == _IslandSection.cosmetics) {
        _cosmeticsFuture ??= bloc.getNewCosmetics();
      }
    });
  }

  void _retry() {
    final bloc = context.read<IslandBloc>();
    setState(() {
      switch (_section) {
        case _IslandSection.map:
          _mapFuture = bloc.getMap();
        case _IslandSection.modes:
          _modesFuture = bloc.getModes();
        case _IslandSection.cosmetics:
          _cosmeticsFuture = bloc.getNewCosmetics();
        case _IslandSection.creator:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Scorebug(
                section: 'ISLA',
                subject: 'Isla',
                channel: kChannelIsland,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: Text('Mapa', style: TextStyle(color: _section == _IslandSection.map ? Colors.white : kInk)),
                    selected: _section == _IslandSection.map,
                    selectedColor: kChannelIsland,
                    backgroundColor: kQuiet,
                    showCheckmark: false,
                    side: BorderSide.none,
                    onSelected: (_) => _select(_IslandSection.map),
                  ),
                  ChoiceChip(
                    label: Text('Modos', style: TextStyle(color: _section == _IslandSection.modes ? Colors.white : kInk)),
                    selected: _section == _IslandSection.modes,
                    selectedColor: kChannelIsland,
                    backgroundColor: kQuiet,
                    showCheckmark: false,
                    side: BorderSide.none,
                    onSelected: (_) => _select(_IslandSection.modes),
                  ),
                  ChoiceChip(
                    label: Text('Novedades', style: TextStyle(color: _section == _IslandSection.cosmetics ? Colors.white : kInk)),
                    selected: _section == _IslandSection.cosmetics,
                    selectedColor: kChannelIsland,
                    backgroundColor: kQuiet,
                    showCheckmark: false,
                    side: BorderSide.none,
                    onSelected: (_) => _select(_IslandSection.cosmetics),
                  ),
                  ChoiceChip(
                    label: Text('Creador', style: TextStyle(color: _section == _IslandSection.creator ? Colors.white : kInk)),
                    selected: _section == _IslandSection.creator,
                    selectedColor: kChannelIsland,
                    backgroundColor: kQuiet,
                    showCheckmark: false,
                    side: BorderSide.none,
                    onSelected: (_) => _select(_IslandSection.creator),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(child: _body()),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    switch (_section) {
      case _IslandSection.map:
        return _SectionLoader<BrMap>(
          future: _mapFuture,
          onRetry: _retry,
          builder: (map) => _MapView(map: map),
        );
      case _IslandSection.modes:
        return _SectionLoader<List<GameMode>>(
          future: _modesFuture,
          onRetry: _retry,
          builder: (modes) => _ModesView(modes: modes),
        );
      case _IslandSection.cosmetics:
        return _SectionLoader<List<NewCosmetic>>(
          future: _cosmeticsFuture,
          onRetry: _retry,
          builder: (cosmetics) => _CosmeticsView(cosmetics: cosmetics),
        );
      case _IslandSection.creator:
        return const _CreatorCodeSearch();
    }
  }
}

class _SectionLoader<T> extends StatelessWidget {
  const _SectionLoader({
    required this.future,
    required this.onRetry,
    required this.builder,
  });

  final Future<T>? future;
  final VoidCallback onRetry;
  final Widget Function(T data) builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            future == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return ErrorRetryView(
            message: snapshot.error.toString(),
            onRetry: onRetry,
          );
        }
        final data = snapshot.data;
        if (!snapshot.hasData || data == null) {
          return const Center(child: Text('No hay datos'));
        }
        return builder(data);
      },
    );
  }
}

class _MapView extends StatelessWidget {
  const _MapView({required this.map});

  final BrMap map;

  @override
  Widget build(BuildContext context) {
    final imageUrl = map.displayImageUrl;
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: InteractiveViewer(
                minScale: 1,
                maxScale: 4,
                child: imageUrl == null
                    ? const ColoredBox(
                        color: Colors.white,
                        child: Center(child: Text('Sin imagen del mapa')),
                      )
                    : Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const Center(child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stack) => const ColoredBox(
                          color: Colors.white,
                          child: Center(child: Text('No se pudo cargar el mapa')),
                        ),
                      ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 56,
          child: map.pois.isEmpty
              ? const Center(child: Text('Sin puntos de interés'))
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: map.pois.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    return Chip(label: Text(map.pois[index].name));
                  },
                ),
        ),
      ],
    );
  }
}

class _ModesView extends StatelessWidget {
  const _ModesView({required this.modes});

  final List<GameMode> modes;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: modes.length,
      separatorBuilder: (_, __) => const Divider(height: 1, color: kQuiet),
      itemBuilder: (context, index) {
        final mode = modes[index];
        final team = mode.teamSize;
        final teamLabel = team == null
            ? null
            : team <= 1
                ? 'En solitario'
                : 'Equipo de $team';
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                mode.imageUrl,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.sports_esports),
              ),
            ),
            title: Text(mode.name, maxLines: 2, overflow: TextOverflow.ellipsis),
            subtitle: Text(
              mode.description.isEmpty ? (teamLabel ?? '') : mode.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: teamLabel == null
                ? null
                : Text(teamLabel, style: const TextStyle(fontSize: 12, color: kInk)),
        );
      },
    );
  }
}

class _CosmeticsView extends StatelessWidget {
  const _CosmeticsView({required this.cosmetics});

  final List<NewCosmetic> cosmetics;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      itemCount: cosmetics.length,
      itemBuilder: (context, index) {
        final item = cosmetics[index];
        final image = item.imageUrl;
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: image == null
                    ? const ColoredBox(
                        color: Colors.white,
                        child: Icon(Icons.image_not_supported),
                      )
                    : Image.network(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.image_not_supported),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(
                      item.rarityLabel.isEmpty
                          ? item.typeLabel
                          : '${item.typeLabel} · ${item.rarityLabel}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: kPrimaryTextColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CreatorCodeSearch extends StatefulWidget {
  const _CreatorCodeSearch();

  @override
  State<_CreatorCodeSearch> createState() => _CreatorCodeSearchState();
}

class _CreatorCodeSearchState extends State<_CreatorCodeSearch> {
  final TextEditingController _controller = TextEditingController();
  Future<CreatorCode>? _future;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _search() {
    final name = _controller.text;
    setState(() {
      _future = context.read<IslandBloc>().lookupCreatorCode(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _controller,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              labelText: 'Código de creador',
              hintText: 'Por ejemplo, ninja',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              suffixIcon: IconButton(
                onPressed: _search,
                icon: const Icon(Icons.search),
              ),
            ),
            onSubmitted: (_) => _search(),
          ),
          const SizedBox(height: 16),
          Expanded(child: _result()),
        ],
      ),
    );
  }

  Widget _result() {
    final future = _future;
    if (future == null) {
      return const Center(
        child: Text(
          'Busca un código de Support-a-Creator',
          textAlign: TextAlign.center,
        ),
      );
    }
    return FutureBuilder<CreatorCode>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return ErrorRetryView(
            message: snapshot.error.toString(),
            onRetry: _search,
          );
        }
        final code = snapshot.data;
        if (code == null) return const Center(child: Text('No hay datos'));
        return _CreatorCodeCard(code: code);
      },
    );
  }
}

class _CreatorCodeCard extends StatelessWidget {
  const _CreatorCodeCard({required this.code});

  final CreatorCode code;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(code.code, style: const TextStyle(fontSize: 28, color: kPrimaryTextColor)),
              const SizedBox(height: 8),
              Text(code.accountName, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 12),
              Text('Estado: ${code.statusLabel}'),
              Text(code.verified ? 'Verificado' : 'No verificado'),
            ],
          ),
        ),
      ),
    );
  }
}
