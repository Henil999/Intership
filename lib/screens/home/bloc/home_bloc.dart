import 'package:bloc/bloc.dart';
import 'package:placement_app/data/models/company.dart';
import 'package:placement_app/data/models/user.dart';
import 'package:placement_app/data/repository/company_repo.dart';
import 'package:placement_app/data/repository/user_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.companyRepo, this.userRepo) : super(HomeState()) {
    on<HomeInitialEvent>(_onInitial);
    on<HomeBookmarkCompanyEvent>(_onBookMarkCompany);
  }

  CompanyRepo companyRepo;
  UserRepo userRepo;
  void _onInitial(HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(state: "Loading"));
    var userC = await userRepo.getUser();
    final companies = await companyRepo.getAllCompanies();

    var user = Student.empty();
    if (userC != null) {
      user.firstName = userC.email;
    }

    emit(state.copyWith(companies: companies, user: user, state: "Success"));
  }

  void _onBookMarkCompany(HomeBookmarkCompanyEvent event, Emitter<HomeState> emit) {
    final company = state.companies[event.companyIndex];

    emit(state.copyWith(bookmarkedCompanies: state.bookmarkedCompanies..add(company)));
  }
}
