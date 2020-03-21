import 'package:bloc/bloc.dart';
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/AddProduct.dart';
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/AddSupplier.dart';
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/Attendance.dart';
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/InternalDashBoard.dart';
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/OverheadExpense.dart';
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/ProductList.dart';
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/Sitephoto.dart';
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/BillPhoto.dart';
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/Stock.dart';
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/SupplierList.dart';
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/TransportationCost.dart';
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/UnitList.dart';

enum NavigationEvents {

  DashBoardClickedEvent,
  SupplierClickedEvent,
  ProductClickedEvent,
  SitePhotoClickedEvent,
  BillPhotoClickedEvent,
  AttendanceClickedEvent,
  TransportationClickedEvent,
  StockClickedEvent,
  ExpenseClickedEvent,
  SupplierListClickedEvent,
  ProductListClickedEvent,
  UnitClickedEvent,

}

abstract class NavigationStates {}


class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  final id,name,sitename,siteId;

  NavigationBloc(this.id,this.name,this.sitename,this.siteId);

  @override
  NavigationStates get initialState => InternalDashBoard(id,name,sitename,siteId);

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.DashBoardClickedEvent:
        yield InternalDashBoard(id,name,sitename,siteId);
        break;
      case NavigationEvents.SupplierClickedEvent:
        yield AddSupplier(id,name,sitename,siteId);
        break;
      case NavigationEvents.ProductClickedEvent:
        yield AddProduct(id,name,sitename,siteId);
        break;
      case NavigationEvents.SitePhotoClickedEvent:
        yield SitePhoto(id,name,sitename,siteId);
        break;
      case NavigationEvents.BillPhotoClickedEvent:
        yield BillPhoto(id,name,sitename,siteId);
        break;
      case NavigationEvents.AttendanceClickedEvent:
        yield Attendance(id,name,sitename,siteId);
        break;
      case NavigationEvents.TransportationClickedEvent:
        yield TransportationCostManager(id,name,sitename,siteId);
        break;
      case NavigationEvents.StockClickedEvent:
        yield Stock(id,name,sitename,siteId);
        break;
      case NavigationEvents.ExpenseClickedEvent:
        yield OverheadExpense(id,name,sitename,siteId);
        break;
      case NavigationEvents.SupplierListClickedEvent:
        yield SupplierList(siteId);
        break;
      case NavigationEvents.ProductListClickedEvent:
        yield ProductList(siteId);
        break;
      case NavigationEvents.UnitClickedEvent:
        yield UnitList();
        break;
    }
  }
}