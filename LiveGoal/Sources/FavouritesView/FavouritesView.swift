/*

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
*/

import SwiftUI

struct FavouritesView: View {

    @StateObject var viewModel = FavouritesViewModel()

    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false){
            Image("laliga_logo_color")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 35)
            Text("Favourite teams")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.bottom, 6)
            
            
                ForEach(0..<self.viewModel.dataFavouriteTeams.count/2) { row in
                    HStack{
                        ForEach(0..<2) { column in
                            
                            
                            NavigationLink(
                                destination: DetailTeamCoordinator.view(dto: DetailTeamCoordinatorDTO(idTeam: self.viewModel.dataFavouriteTeams[row * 2 + column].getIdInt(), season: self.viewModel.dataCurrentSeasonLeague?.year ?? 0, idLeague: Constants.laLigaId)),
                                label: {
                                    FavouriteItem(model: self.viewModel.dataFavouriteTeams[row * 2 + column])
                            }).buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            .padding(.horizontal, 8)
        }
        .padding(.bottom, 80)
        .padding(.top, 50)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            self.viewModel.fetchData()
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}

