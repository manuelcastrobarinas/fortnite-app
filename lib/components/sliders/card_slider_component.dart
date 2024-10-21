import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

typedef WidgetFunction<T> = Widget Function(T value);

class CardSlider extends StatefulWidget {

  final List<Widget> cards;  // Lista de widgets

  final ValueChanged<void>? slideChanged; // evento que se dispara cuando se cambia de tarjeta, (el evento se dispara de la tarjeta actual)
  final Widget? sliderBackGroundWidget;
  final double? itemDotWidth; // Opcional es un ancho de puntos debajo del control deslizante que muestra la ubicación actual.
  final double? bottomOffset; // Opcional es un valor doble, la altura de una parte inferior de la diapositiva anterior
  final double? cardWidth;   //Opcional es un ancho de la card
  final double? cardHeight;   // Opcional es el alto de la card
  final double? cardWidthOffset; 	//Opcional es un ancho que se utiliza para qué tan lejos debe ir la diapositiva en distancia horizontal al deslizar o arrastrar
  final double? cardHeightOffset; //Opcional es una altura que se utiliza para qué tan lejos debe llegar la diapositiva en distancia vertical al deslizar o arrastrar
  final WidgetFunction<double>? itemDot; //	Opcional es un widget por el cual se pueden cambiar los puntos de la posición del control deslizante
  final double? containerWidth; 	// Opcional es un ancho de contenedor principal
  final double? containerHeight;  //Opcional es una altura del contenedor principal
  final Color? containerColor;  //	Opcional es un color del contenedor principal
  final double? itemDotOffset;  //  Opcional es una distancia para colocar itemDot debajo de las diapositivas
  final void Function(int) setIndexSelectedItem; //funcion para ingresar el index de la card que se esta mostrando
 
  const CardSlider({
    super.key,
    required this.cards,
    this.slideChanged,  
    this.sliderBackGroundWidget,
    this.itemDotWidth = 10,
    this.bottomOffset = .0003,
    this.cardWidth = .9,
    this.cardHeight = .85,
    this.cardWidthOffset = .1,
    this.cardHeightOffset = .01,
    this.containerWidth = double.infinity,
    this.containerHeight = 500,
    this.containerColor = Colors.transparent,
    this.itemDotOffset = 0,
    this.itemDot,
    required this.setIndexSelectedItem
  });

  @override
  State<CardSlider> createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double alignmentCenterY = Alignment.center.y;

  late Alignment _dragAlignment;
  late Alignment _dragAlignmentBack;
  double _dragAlignmentCenter = 0;

  late Animation<Alignment> _dragAlignmentAnim;
  late Animation<double> _dragAlignmentCenterAnim;
  late Animation<double> _containerSizeWidthAnim;
  late Animation<double> _containerSizeHeightAnim;
  late Animation<double> _itemDotWidthAnim;

  double _containerSizeWidth = 0;
  double _containerSizeHeight = 0;

  int _animationPhase = 0;
  bool animationPhase3 = false;

  List<int> valuesDataIndex = [];

  bool directionX = false;
  bool directionNegative = false;

  late double _cardWidth;
  late double _cardWidthOffset;
  late double _cardHeight;
  late double _cardHeightOffset;

  late double _bottomOffset;
  static const double _slideRightOffset = -18.0;
  static const double _slideLeftOffset = 5.55;
  static const double _slideTopOffset = -1.6;
  static const double _slideBottomOffset = 1.9;

  /// Calcula y ejecuta una [SpringSimulation].
  void _cardToBackAnimation(Offset pixelsPerSecond, Size size) {
    directionX = false;

    _dragAlignmentAnim = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment(
          Alignment.center.x, alignmentCenterY + 0 //(showHide ? 0.1 * ((valuesData.length - 1) - 0): 0)
        )
      ),
    );
    // Calcula la velocidad relativa al intervalo unitario, [0,1],
    // utilizado por el controlador de animación.
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 60,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);
    _controller.animateWith(simulation);
  }

// mueve la tarjeta a una posición específica, cuando el usuario termina de arrastrar,
  // 1. (primera acción) la tarjeta debe estar posicionada para moverse a la ubicación más lejana
  // 2. (segunda acción) se debe posicionar la carta para pasar a la posición inicial
  Alignment getTheAlignment(bool directionNegative, [bool withOutDirection = false]) {
    Alignment dragAlignmentSelect = directionNegative ? _dragAlignmentBack : _dragAlignment;
    return Alignment(
      Alignment.center.x +(directionX || withOutDirection
        ? (dragAlignmentSelect.x == 0 || dragAlignmentSelect.x.abs() < 0.1
          ? 0
          : (dragAlignmentSelect.x > 0
            ? _slideLeftOffset
            : _slideRightOffset))
        : 0),
        alignmentCenterY +
            ( withOutDirection
                ? (dragAlignmentSelect.y + alignmentCenterYOffset * -1 == 0 ||
                        (dragAlignmentSelect.y + alignmentCenterYOffset * -1)
                                .abs() <
                            0.1
                    ? 0
                    : (dragAlignmentSelect.y + alignmentCenterYOffset * -1 > 0
                        ? _slideBottomOffset
                        : _slideTopOffset))
                : 0));
  }

  // Cuando finaliza el arrastre del usuario, si la distancia es superior al mínimo para iniciar la animación,
  // luego se inicializa el proceso de animación estática.
  // Esta es la primera fase del inicio de la animación.
  void _cardToStartAnimation(Offset pixelsPerSecond, Size size) {
    _dragAlignmentAnim = _controller.drive<Alignment>(
      AlignmentTween(
        begin: directionNegative ? _dragAlignmentBack : _dragAlignment,
        end: getTheAlignment(directionNegative)
      ),
    );

    // Calcula la velocidad relativa al intervalo unitario, [0,1],
    // utilizado por el controlador de animación.
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 60,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller
      .animateWith(simulation)
      .then((value) => <void> {_cardToFinishAnimation(pixelsPerSecond, size)});
  }

  // Establece todos los valores al estado inicial
  void _setInitialValues() {
    _containerSizeWidth = 0;
    _containerSizeHeight = 0;
    _dragAlignmentCenter = 0;

    directionX = false;


  }

  // Esta es la segunda (última) fase del inicio de la animación.
  void _cardToFinishAnimation(Offset pixelsPerSecond, Size size) {
    _setInitialValues();

    _animationPhase = 3;
    animationPhase3 = true;

    if (directionNegative) {
      int i = valuesDataIndex[valuesDataIndex.length - 1];
      valuesDataIndex.removeAt(valuesDataIndex.length - 1);
      valuesDataIndex.insert(0, i);
      _dragAlignment = _dragAlignmentBack;
      _dragAlignmentBack = Alignment(Alignment.center.x,
          alignmentCenterY + getAlignment(valuesDataIndex.length - 1));
      if (i == valuesDataIndex.length) { //AÑADE EL ITEM SELECCIONADO AL GESTOR DE ESTADO DE LA TIENDA
        widget.setIndexSelectedItem(0);
      } else { //AÑADE EL ITEM SELECCIONADO AL GESTOR DE ESTADO DE LA TIENDA
        widget.setIndexSelectedItem(i); 
      }
    } else {
      int i = valuesDataIndex[0];
      valuesDataIndex.removeAt(0);
      valuesDataIndex.add(i);
      _dragAlignmentBack = _dragAlignment;
      _dragAlignment = Alignment(Alignment.center.x, alignmentCenterY);
      if (i == valuesDataIndex.length) {
        widget.setIndexSelectedItem(0);
      } else {
      widget.setIndexSelectedItem(i+1);
      }
    }

    _dragAlignmentCenterAnim =
        _controller.drive(Tween<double>(begin: 0, end: -1 * _bottomOffset));

    _itemDotWidthAnim =
        _controller.drive(Tween<double>(begin: 0, end: _itemDotWidth));

    _containerSizeWidthAnim =
        _controller.drive(Tween<double>(begin: 0, end: _cardWidthOffset));

    _containerSizeHeightAnim =
        _controller.drive(Tween<double>(begin: 0, end: _cardHeightOffset));

    _dragAlignmentAnim = _controller.drive(
      AlignmentTween(
        begin: getTheAlignment(!directionNegative, true),
        end: directionNegative
          ? Alignment(Alignment.center.x, alignmentCenterY)
          : Alignment(Alignment.center.x, alignmentCenterY + getAlignment(valuesDataIndex.length - 1))
      ),
    );
    // Calcula la velocidad relativa al intervalo unitario, [0,1],
    // utilizado por el controlador de animación.
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 60,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation).then((value) => {
      _animationPhase = 0,
    });
  }

  @override
  void initState() {
    super.initState();

    _setInitialValues();

    alignmentCenterY += alignmentCenterYOffset;

    _dragAlignment = Alignment(Alignment.center.x, alignmentCenterY);
    _dragAlignmentBack = Alignment(Alignment.center.x, alignmentCenterY);

    for (int i = 0; i < widget.cards.length; i++) {
      valuesDataIndex.add(i);
    }

    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      setState(() {
        if (_animationPhase == 0 || _animationPhase == 1) {
          directionNegative
            ? _dragAlignmentBack = _dragAlignmentAnim.value
            : _dragAlignment = _dragAlignmentAnim.value;
        }
        if (_animationPhase == 3) {
          directionNegative
            ? _dragAlignment = _dragAlignmentAnim.value
            : _dragAlignmentBack = _dragAlignmentAnim.value;

          _dragAlignmentCenter = _dragAlignmentCenterAnim.value;
          _containerSizeWidth = _containerSizeWidthAnim.value;
          _containerSizeHeight = _containerSizeHeightAnim.value;
          _itemDotWidth = _itemDotWidthAnim.value;
        }
      });
    });
    widget.setIndexSelectedItem(0); //Seteamos el index en la posicion 0 siempre que se carge por primera vez las tarjetas
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ignore: prefer_typing_uninitialized_variables
  late var _size;

  bool runOnlyOnce = false;

  @override
  Widget build(BuildContext context) {
    if (!runOnlyOnce) {
      _size = MediaQuery.of(context).size;
      _itemDotWidth = widget.itemDotWidth ?? 10;
      _cardWidth = _size.width * widget.cardWidth;
      _cardHeight = _size.width * widget.cardHeight;
      _cardWidthOffset = _size.width * widget.cardWidthOffset;
      _cardHeightOffset = _size.width * widget.cardHeightOffset;
      _bottomOffset = _size.width * widget.bottomOffset;
      _dragAlignmentBack = Alignment(Alignment.center.x,
          alignmentCenterY + getAlignment(valuesDataIndex.length - 1));
      runOnlyOnce = true;
    }

    return Container(
      color: widget.containerColor,
      height: widget.containerHeight,
      width: widget.containerWidth,
      child: Stack(
        children: _sliderBody(),
      )
    );
  }

// el cuerpo principal, detector de gestos, widgets de diapositivas
  List<Widget> _sliderBody() {
    return [
      if (widget.sliderBackGroundWidget != null) widget.sliderBackGroundWidget!,
      animatedBackCards(),
      GestureDetector(
        onPanDown: (details) {
          if (_animationPhase == 0) _controller.stop();
        },
        onPanUpdate: (details) {
          if (_animationPhase == 0) {
            if (!directionX) {
              if (details.delta.dx != 0.0) {
                if (((details.delta.dx).abs() - (details.delta.dy).abs())
                        .abs() >
                    0.2) {
                  if ((details.delta.dx).abs() > (details.delta.dy).abs()) {
                    directionX = true;
                    directionNegative = details.delta.dx > 0;
                  }
                }
              }
            }
            if (directionX) {
              setState(() {
                if (directionNegative) {
                  _dragAlignmentBack += Alignment(
                    directionX ? details.delta.dx / (_size.width / 2) : 0,
                    0,
                  );
                } else {
                  _dragAlignment += Alignment(
                    directionX ? details.delta.dx / (_size.width / 2) : 0,
                    0,
                  );
                }
              });
            }
          }
        },
        onPanEnd: (details) {
          if (_animationPhase == 0) {
            if ( directionX
                    ? (directionNegative
                        ? _dragAlignmentBack.x.abs() > 0.2
                        : _dragAlignment.x.abs() > 0.2)
                    : false) {
              _animationPhase = 1;
              _cardToStartAnimation(details.velocity.pixelsPerSecond, _size);
            } else {
              _cardToBackAnimation(details.velocity.pixelsPerSecond, _size);
            }
          }
        },
        child: Container(
          width: _size.width,
          height: _size.height,
          color: const Color(0x0000ff77),
        ),
      ),
    ];
  }

  // each card which goes after must be located below
  double getAlignment(int i) {
    double bottomOffset = 0;
    if (i > 1) return bottomOffset += _bottomOffset * 2;
    if (i > 0) return bottomOffset += _bottomOffset;
    return bottomOffset;
  }

  // cada carta que sigue debe ser más pequeña
  // para hacer ilusión si fuera 3d o para mostrarle al usuario que hay más tarjetas para deslizar
  double getWidth(int i) {
    double width = _cardWidth;
    if (i > 1) return width -= _cardWidthOffset * 2;
    if (i > 0) return width -= _cardWidthOffset;
    return width;
  }
// cada carta que sigue debe ser más pequeña
  // para hacer ilusión si fuera 3d o para mostrarle al usuario que hay más tarjetas para deslizar
  double getHeight(int i) {
    double height = _cardHeight;
    if (i > 1) return height -= _cardHeightOffset * 2;
    if (i > 0) return height -= _cardHeightOffset;
    return height;
  }

  double alignmentCenterYOffset = -0.6;
  double _itemDotWidth = 10;

// Opcional es un widget mediante el cual se pueden cambiar los puntos de la posición del control deslizante
  Widget itemDot(double itemDotWidth) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 5 + itemDotWidth,
      height: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      )
    );
  }
// puntos de navegación, control deslizante que no mueve diapositivas - fondo
  Widget animatedBackCards() {
    return Stack(
      children: [
        for (int index = 0; index < widget.cards.length; index++)
          for (int i = (widget.cards.length - 1); i >= 0; i--)
            Align(
              alignment: (i == 0 || i == widget.cards.length - 1)
                  ? (i == 0
                      ? Alignment(
                          _dragAlignment.x,
                          _dragAlignment.y + _dragAlignmentCenter + (animationPhase3 ? _bottomOffset : 0),
                        )
                      : _dragAlignmentBack)
                  : Alignment(
                      Alignment.center.x,
                      alignmentCenterY + getAlignment(i) + _dragAlignmentCenter + (animationPhase3 ? _bottomOffset : 0),
                    ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                width: getWidth(i) + _containerSizeWidth + (animationPhase3 ? -1 * _cardWidthOffset : 0),
                height: getHeight(i) + _containerSizeHeight + (animationPhase3 ? -1 * _cardHeightOffset : 0),
                child: Transform.rotate(
                  angle: i == 0
                      ? 7.33 * (3.141592653589793 / 180)
                      : i == 1
                          ? -7.33 * (3.141592653589793 / 180)
                          : 0,
                  child: (valuesDataIndex.length > i && valuesDataIndex[i] < widget.cards.length)
                      ? widget.cards[valuesDataIndex[i]]
                      : const SizedBox(), // Manejo del caso en que el índice no es válido
                ),
              ),
            ),
      ],
    );
  }
}