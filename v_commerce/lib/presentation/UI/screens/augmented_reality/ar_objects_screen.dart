import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/domain/entities/node.dart';
import 'package:v_commerce/domain/entities/product3d.dart';
import 'package:v_commerce/presentation/controllers/ar_controller.dart';
import 'package:vector_math/vector_math_64.dart';

class ObjectGesturesWidget extends StatefulWidget {
 final List<Product3D> models;
 final bool? isSingleProduct;
 const ObjectGesturesWidget({Key? key,required this.models,this.isSingleProduct}) : super(key: key);
  @override
    // ignore: library_private_types_in_public_api
    _ObjectGesturesWidgetState createState() => _ObjectGesturesWidgetState();
}

class _ObjectGesturesWidgetState extends State<ObjectGesturesWidget> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;
  bool showPlane =true;
  String? selectedNode=null;
  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];
  List<Node> myNodes=[];
  String url='';

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }
  
  @override
  void initState() {
    url=widget.models[0].model3D;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            extendBodyBehindAppBar: true,

      extendBody: true,
        appBar: AppBar(
         backgroundColor: AppColors.transparent,
        elevation: 0,
          actions:widget.isSingleProduct??false ?[]: [Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: GetBuilder(
              init: AugmentedRealityController(),
              builder: (controller) {
                return FloatingActionButton.small(onPressed: (){
                  controller.rotate();
                },elevation: 0,backgroundColor: AppColors.transparentSecondary,
                
                child:AnimatedRotation(
                  turns: controller.rotation,
                  duration:const Duration(milliseconds: 300),
                  child: const Icon(Icons.add,color: AppColors.white,)),);
              }
            ),
          )],
        ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

floatingActionButton: Padding(
  padding: const EdgeInsets.symmetric( horizontal:15.0 ,vertical: 25),
  child:   Row(
  
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  
    children: [
  
    FloatingActionButton(heroTag: null, onPressed: (){
      if( selectedNode!=null){
        onDeleteNode();
      }
    },shape: const CircleBorder(),backgroundColor: AppColors.transparentSecondary,elevation: 0,child:  SvgPicture.string(APPSVG.removeIcon),),
      SizedBox(
        width: 80,
        height: 80,
        child: FittedBox(child: FloatingActionButton(heroTag: null, onPressed:onTakeScreenshot,shape: const CircleBorder(),backgroundColor: AppColors.white,elevation: 0,child:  SvgPicture.string(APPSVG.screenshotButtonIcon,width: 50,),))),
    FloatingActionButton(heroTag: null,onPressed: onRemoveEverything
    ,shape: const CircleBorder(),backgroundColor: AppColors.transparentSecondary,elevation: 0,child:  SvgPicture.string(APPSVG.clearIcon),)
  
  ],),
),

        body: Container(
            child: Stack(children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          GetBuilder(
            init: AugmentedRealityController(),
            builder: (controller) {
              return AnimatedPositioned(
                duration:const Duration(milliseconds: 300),
                right: controller.slide,
                top: 100,
                child: Container(height: 500.h,width: 140.w,
                decoration: BoxDecoration(
                  color: AppColors.transparentSecondary,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: 
                ListView.builder(
                  padding:const EdgeInsets.symmetric(vertical:10.0,horizontal: 20), 
                  itemCount: widget.models.length,
                  itemBuilder:(_,index){
                  return InkWell(
                    onTap: () {
                      setState(() {
                        url=widget.models[index].model3D;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                        border:  widget.models[index].model3D==url? Border.all(width: 4,color: AppColors.secondary):null,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(widget.models[index].texture,fit: BoxFit.fitHeight, height: 100,))),
                    ),
                  );
                })
                ));
            }
          )
        ])));
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager!.onInitialize(
          //showFeaturePoints: true,
          showPlanes: showPlane,
          //customPlaneTexturePath: "Images/triangle.png",
         // showWorldOrigin: true,
          handlePans: true,
          handleRotation: true,
        );
    this.arObjectManager!.onInitialize();

    this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
    this.arObjectManager!.onPanStart = onPanStarted;
    this.arObjectManager!.onPanChange = onPanChanged;
    this.arObjectManager!.onPanEnd = onPanEnded;
    this.arObjectManager!.onRotationStart = onRotationStarted;
    this.arObjectManager!.onRotationChange = onRotationChanged;
    this.arObjectManager!.onRotationEnd = onRotationEnded;
    this.arObjectManager!.onNodeTap = onNodeTap;
  }

  onDeleteNode(){
      String anchor = myNodes.firstWhere((element) => element.nodeName==selectedNode).anchorName;
      ARAnchor canchor = anchors.firstWhere((element) => element.name==anchor);
           this.arObjectManager!.removeNode(nodes.firstWhere((element) => element.name==selectedNode));
            this.arAnchorManager!.removeAnchor(anchors.firstWhere((element) => element.name==anchor));
           print('node deleted $myNodes');
           anchors.remove(canchor);
        //   nodes.removeWhere((element) => element)

  }

  Future<void>? onNodeTap(List<String> nodes){
   var number = nodes.length;
   //print('Tapped node');
   print('node[] $nodes');
      print('anchors node[] ${anchors.first.name}');
   print('node number $number');
   setState(() {
        selectedNode=nodes[0];
   });
   return null;
  }

  Future<void> onRemoveEverything() async {
    /*nodes.forEach((node) {
      this.arObjectManager.removeNode(node);
    });*/
    anchors.forEach((anchor) {
      this.arAnchorManager!.removeAnchor(anchor);
    });
    anchors = [];
  }

  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    var singleHitTestResult = hitTestResults.firstWhere(
        (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
    // ignore: unnecessary_null_comparison
    if (singleHitTestResult != null) {
      var newAnchor =
          ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
      bool? didAddAnchor = await this.arAnchorManager!.addAnchor(newAnchor);
      if (didAddAnchor!) {
        this.anchors.add(newAnchor);
//print('add node');

        // Add note to anchor
        var newNode = ARNode(
            type: NodeType.webGLB,
            uri:
               url,
            scale: Vector3(0.1, 0.1, 0.1),
            position: Vector3(0.0, 0.0, 0.0),
            rotation: Vector4(1.0, 0.0, 0.0, 0.0));
        bool? didAddNodeToAnchor =
            await this.arObjectManager!.addNode(newNode, planeAnchor: newAnchor);
        if (didAddNodeToAnchor!) {
          print('add node');

          this.nodes.add(newNode);
          myNodes.add(Node(nodeName: newNode.name, anchorName: newAnchor.name));

        } else {
          this.arSessionManager!.onError("Adding Node to Anchor failed");
        }
      } else {
        this.arSessionManager!.onError("Adding Anchor failed");
      }
    }
  }

  onPanStarted(String nodeName) {
    print("Started panning node " + nodeName);
  }

  onPanChanged(String nodeName) {
    print("Continued panning node " + nodeName);
  }

  onPanEnded(String nodeName, Matrix4 newTransform) {
    print("Ended panning node " + nodeName);
        this.nodes.firstWhere((element) => element.name == nodeName);

    /*
    * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
    * (e.g. if you intend to share the nodes through the cloud)
    */
    //pannedNode.transform = newTransform;
            setState(() {
        selectedNode=null;
   });
  }

    Future<void> onTakeScreenshot() async {
            //   showPlane= false;

    var image = await arSessionManager!.snapshot();
    // ignore: use_build_context_synchronously
    await ImageGallerySaver.saveImage((image as MemoryImage).bytes);

    await showDialog(
        context: context,
        builder: (_) => Dialog(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(image: image, fit: BoxFit.cover)),
              ),
            ));
            //   showPlane= true;
    
  }

  onRotationStarted(String nodeName) {
    print("Started rotating node " + nodeName);
  }

  onRotationChanged(String nodeName) {
    print("Continued rotating node " + nodeName);
  }

  onRotationEnded(String nodeName, Matrix4 newTransform) {
    print("Ended rotating node " + nodeName);
        this.nodes.firstWhere((element) => element.name == nodeName);
        setState(() {
        selectedNode=null;
   });

    /*
    * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
    * (e.g. if you intend to share the nodes through the cloud)
    */
    //rotatedNode.transform = newTransform;
  }
  
}