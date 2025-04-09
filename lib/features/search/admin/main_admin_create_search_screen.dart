import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/search/view_model/search_admin_view_model.dart';
import 'package:marketlyze_1/features/widget/review.widget/create_review_choose_type_widget.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MainAdminCreaeSearchScreen extends ConsumerStatefulWidget {
  const MainAdminCreaeSearchScreen({super.key});

  @override
  ConsumerState<MainAdminCreaeSearchScreen> createState() =>
      _MainAdminCreaeSearchScreenState();
}

class _MainAdminCreaeSearchScreenState
    extends ConsumerState<MainAdminCreaeSearchScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  Map<String, String> formData = {};
  Map<String, double> doubleData = {};

  //final List<File> _selectedImage = [];
  List<Asset> _selectedThumbnail = [];
  List<Asset> _selectedBanner = [];

  String _title = "";
  String _product = "";
  String _business = "";
  String _content = "";

// ---------- 아이콘 선택 값 ---------- //

  int _selectedIndex = 0;

// ---------- 별점 표시 값 ---------- //

  double ratingTo1 = 0;
  double ratingTo2 = 0;
  double ratingTo3 = 0;
  double ratingTo4 = 0;
  double ratingTo5 = 0;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() {
      setState(() {
        _title = _titleController.text;
      });
    });
    _productNameController.addListener(() {
      setState(() {
        _product = _productNameController.text;
      });
    });
    _companyNameController.addListener(() {
      setState(() {
        _business = _companyNameController.text;
      });
    });
    _contentController.addListener(() {
      setState(() {
        _content = _contentController.text;
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _productNameController.dispose();
    _companyNameController.dispose();
    _contentController.dispose();
    super.dispose();
  }

// ---------- 텍스트 입력 함수 ---------- //

  String? _isTitleValid() {
    if (_title.isEmpty) {
      return "Write your title please";
    }
    if (_title.length == 50) {
      return "Max length";
    }
    return null;
  }

  String? _isProductNameValid() {
    if (_product.isEmpty) {
      return "Write your product name please";
    }
    if (_product.length == 100) {
      return "Max length";
    }
    return null;
  }

  String? _isBusinessNameValid() {
    if (_business.isEmpty) {
      return "Write your company name please";
    }
    if (_business.length == 100) {
      return "Max length";
    }
    return null;
  }

  String? _isContentValid() {
    if (_content.isEmpty) {
      return "Wtite your content please";
    }
    if (_content.length == 200) {
      return "Max length";
    }

    return null;
  }

// ---------- 아이콘 선택시 별점 재목 변경 함수 ---------- //

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
      //print(_selectedIndex);
    });
  }

//----------  겔러리 사진 thumnail 전달 함수 ---------- //

  // Future _pickImageFromGallery() async {
  //   final xfile = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 40,
  //     maxHeight: 150,
  //     maxWidth: 150,
  //   );
  //   if (xfile != null) {
  //     final selectedImage = File(xfile.path);
  //     _selectedImage.add(selectedImage);
  //   }
  //   print(_selectedImage);

  //   setState(() {});
  // }

  Future<void> _pickThumnail() async {
    // 권한을 요청하고 권한 상태를 확인
    var status = await Permission.photos.status;
    if (status.isGranted) {
      status = await Permission.photos.request();
      if (status.isDenied) {
        // 권한이 거부되었을 때 처리
        print("갤러리 접근 권한이 거부되었습니다.");
        return;
      }
    }

    // 권한이 부여되었으므로 이미지를 선택하는 로직 실행
    List<Asset> resultList = [];
    try {
      resultList = await MultipleImagesPicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: _selectedThumbnail,
        cupertinoOptions: const CupertinoOptions(
          selectionFillColor: "#2cbcfa", // 선택한 이미지 배경색 변경
          selectionCharacter: "✓",
        ),
        materialOptions: const MaterialOptions(
          actionBarTitle: "Select Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          actionBarColor: "#2cbcfa", // 액션바 색상 변경
          actionBarTitleColor: "#ffffff", // 액션바 제목 색상 변경
          statusBarColor: "#2cbcfa", // 상태 표시줄 색상 변경
        ),
      );
    } on Exception catch (e) {
      // 에러 처리
      print("Error: $e");
    }
    if (!mounted) return;
    setState(() {
      _selectedThumbnail = resultList;
    });
  }

  //----------  겔러리 사진 banner 전달 함수 ---------- //

  Future<void> _pickBanner() async {
    // 권한을 요청하고 권한 상태를 확인
    var status = await Permission.photos.status;
    if (status.isGranted) {
      status = await Permission.photos.request();
      if (status.isDenied) {
        // 권한이 거부되었을 때 처리
        //print("갤러리 접근 권한이 거부되었습니다.");
        return;
      }
    }

    // 권한이 부여되었으므로 이미지를 선택하는 로직 실행
    List<Asset> resultList = [];
    try {
      resultList = await MultipleImagesPicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: _selectedBanner,
        cupertinoOptions: const CupertinoOptions(
          selectionFillColor: "#2cbcfa", // 선택한 이미지 배경색 변경
          selectionCharacter: "✓",
        ),
        materialOptions: const MaterialOptions(
          actionBarTitle: "Select Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          actionBarColor: "#2cbcfa", // 액션바 색상 변경
          actionBarTitleColor: "#ffffff", // 액션바 제목 색상 변경
          statusBarColor: "#2cbcfa", // 상태 표시줄 색상 변경
        ),
      );
    } on Exception catch (e) {
      // 에러 처리
      print("Error: $e");
    }
    if (!mounted) return;
    setState(() {
      _selectedBanner = resultList;
    });
  }

//----------  firebase 전달 함수 ---------- //

  void _onUploadPress() {
    // ref.read(reviewProvider.notifier).createReview(
    //       ratingTo: doubleData,
    //       data: formData,
    //       selectedIndex: _selectedIndex,
    //       images: _selectedImages,
    //     );
    ref.read(searchAdminProvider.notifier).createSearch(
          thumbnail: _selectedThumbnail,
          banner: _selectedBanner,
          data: formData,
          selectedIndex: _selectedIndex,
        );
    Navigator.pop(context);
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Survey"),
        actions: [
          IconButton(
            onPressed: _onUploadPress,
            icon: const FaIcon(
              FontAwesomeIcons.arrowRightFromBracket,
              size: Sizes.size24,
            ),
          ),
          Gaps.h8
        ],
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const FaIcon(
            FontAwesomeIcons.angleLeft,
            size: Sizes.size20,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: _onScaffoldTap,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
              Sizes.size24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------- 사진 업데이트 ---------- //
                const Text("thumbnail"),
                Gaps.v10,
                GestureDetector(
                  //onTap: _pickImageFromGallery,
                  onTap: _pickThumnail,
                  child: SizedBox(
                    height: Sizes.size96,
                    width: Sizes.size96,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 224, 243, 255),
                        borderRadius: BorderRadius.circular(
                          Sizes.size14,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.shade100,
                            blurRadius: 5,
                            spreadRadius: 0.1,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Gaps.v5,
                          FaIcon(
                            FontAwesomeIcons.camera,
                            size: Sizes.size28,
                          ),
                          Gaps.v5,
                          Text(
                            "0/10",
                            style: TextStyle(
                              fontSize: Sizes.size16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Gaps.v10,
                const Text("banner"),
                Gaps.v10,
                GestureDetector(
                  //onTap: _pickImageFromGallery,
                  onTap: _pickBanner,
                  child: SizedBox(
                    height: Sizes.size96,
                    width: Sizes.size96,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 224, 243, 255),
                        borderRadius: BorderRadius.circular(
                          Sizes.size14,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.shade100,
                            blurRadius: 5,
                            spreadRadius: 0.1,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Gaps.v5,
                          FaIcon(
                            FontAwesomeIcons.camera,
                            size: Sizes.size28,
                          ),
                          Gaps.v5,
                          Text(
                            "0/10",
                            style: TextStyle(
                              fontSize: Sizes.size16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Gaps.v28,

                // ---------- 제목 업데이트 ---------- //

                const Text(
                  "Title",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextField(
                  controller: _titleController,
                  maxLength: 50,
                  autocorrect: false,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    counterText: "50 / ${_title.length.toString()}",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                    ),
                    hintText: "Write title",
                    errorText: _isTitleValid(),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  onChanged: (newValue) {
                    formData["title"] = newValue;
                  },
                ),
                Gaps.v28,

                // ---------- 상품이름 업데이트 ---------- //

                const Text(
                  "Product name",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextField(
                  controller: _productNameController,
                  maxLength: 100,
                  autocorrect: false,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    counterText: "100 / ${_product.length.toString()}",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                    ),
                    hintText: "Write product name",
                    errorText: _isProductNameValid(),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  onChanged: (newValue) {
                    formData["productName"] = newValue;
                  },
                ),
                Gaps.v28,

                // ---------- 회사이름 업데이트 ---------- //

                const Text(
                  "Company name",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextField(
                  controller: _companyNameController,
                  maxLength: 100,
                  autocorrect: false,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    counterText: "100 / ${_business.length.toString()}",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                    ),
                    hintText: "Write company name",
                    errorText: _isBusinessNameValid(),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  onChanged: (newValue) {
                    formData["business"] = newValue;
                  },
                ),
                Gaps.v28,

                // ---------- 세부 항목 업데이트 ---------- //

                const Text(
                  "Product type",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size24,
                  ),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: Sizes.size10,
                    runSpacing: Sizes.size10,
                    children: [
                      CreateReviewChooseTypeWidget(
                        icon: FontAwesomeIcons.utensils,
                        text: "Food",
                        select: _selectedIndex == 0,
                        selectedIndex: _selectedIndex,
                        onTap: () => _onTap(0),
                      ),
                      CreateReviewChooseTypeWidget(
                        icon: FontAwesomeIcons.shirt,
                        text: "Cloth",
                        select: _selectedIndex == 1,
                        selectedIndex: _selectedIndex,
                        onTap: () => _onTap(1),
                      ),
                      CreateReviewChooseTypeWidget(
                        icon: FontAwesomeIcons.shapes,
                        text: "Toy",
                        select: _selectedIndex == 2,
                        selectedIndex: _selectedIndex,
                        onTap: () => _onTap(2),
                      ),
                      CreateReviewChooseTypeWidget(
                        icon: FontAwesomeIcons.basketball,
                        text: "Sport",
                        select: _selectedIndex == 3,
                        selectedIndex: _selectedIndex,
                        onTap: () => _onTap(3),
                      ),
                      CreateReviewChooseTypeWidget(
                        icon: FontAwesomeIcons.paw,
                        text: "Pet",
                        select: _selectedIndex == 4,
                        selectedIndex: _selectedIndex,
                        onTap: () => _onTap(4),
                      ),
                      CreateReviewChooseTypeWidget(
                        icon: FontAwesomeIcons.couch,
                        text: "Home",
                        select: _selectedIndex == 5,
                        selectedIndex: _selectedIndex,
                        onTap: () => _onTap(5),
                      ),
                      CreateReviewChooseTypeWidget(
                        icon: FontAwesomeIcons.jugDetergent,
                        text: "Daily",
                        select: _selectedIndex == 6,
                        selectedIndex: _selectedIndex,
                        onTap: () => _onTap(6),
                      ),
                      CreateReviewChooseTypeWidget(
                        icon: FontAwesomeIcons.babyCarriage,
                        text: "Baby",
                        select: _selectedIndex == 7,
                        selectedIndex: _selectedIndex,
                        onTap: () => _onTap(7),
                      ),
                      CreateReviewChooseTypeWidget(
                        icon: FontAwesomeIcons.book,
                        text: "Book",
                        select: _selectedIndex == 8,
                        selectedIndex: _selectedIndex,
                        onTap: () => _onTap(8),
                      ),
                      CreateReviewChooseTypeWidget(
                        icon: FontAwesomeIcons.heartPulse,
                        text: "Health",
                        select: _selectedIndex == 9,
                        selectedIndex: _selectedIndex,
                        onTap: () => _onTap(9),
                      ),
                      // CreateReviewChooseTypeWidget(
                      //   icon: FontAwesomeIcons.car,
                      //   text: "Moblity",
                      //   select: _selectedIndex == 10,
                      //   selectedIndex: _selectedIndex,
                      //   onTap: () => _onTap(10),
                      // ),
                      CreateReviewChooseTypeWidget(
                        icon: FontAwesomeIcons.pen,
                        text: "Office",
                        select: _selectedIndex == 10,
                        selectedIndex: _selectedIndex,
                        onTap: () => _onTap(10),
                      ),
                    ],
                  ),
                ),
                Gaps.v10,

                // ---------- 세부평점 업데이트 ---------- //

                const Text(
                  "Content",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Gaps.v12,
                TextField(
                  minLines: 3,
                  maxLines: 8,
                  maxLength: 200,
                  controller: _contentController,
                  autocorrect: false,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                    ),
                    hintText: "Write Content",
                    errorText: _isContentValid(),
                    counterText: "200 / ${_content.length.toString()}",
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: Sizes.size10,
                      horizontal: Sizes.size14,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                      borderRadius: BorderRadius.circular(
                        Sizes.size8,
                      ),
                    ),
                  ),
                  onChanged: (newValue) {
                    formData["content"] = newValue;
                  },
                ),
                Gaps.v28,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
