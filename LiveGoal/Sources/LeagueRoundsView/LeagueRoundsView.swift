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

struct LeagueRoundsView: View {

    @StateObject var viewModel = LeagueRoundsViewModel()
    @State private var roundSelected = 1
    //var seasonRounds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,20, 21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38]
    
    var body: some View {
        VStack(spacing: 20, content: {
            HStack{
                Text("Round \(roundSelected)")
                    .font(.title2).fontWeight(.bold)
                    .onReceive(self.viewModel.$dataCurrentLeagueRound) { currentRound in
                        self.roundSelected = currentRound
                    }
                Spacer()
                Picker("Select round", selection: $roundSelected){
                    ForEach(self.viewModel.dataLeagueRounds, id: \.self){
                        Text("Round \($0)")
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .font(.title2)
            }
            .padding(20)
            
            ScrollView{
                VStack{
//                    if let matchesUnw = self.viewModel.dataMatchesLeague[roundSelected] {
//                        MatchesList(matches: matchesUnw)
//                    }else{
//                        Text("There are no matches for this round")
//                            .font(.title)
//                            .fontWeight(.bold)
//                    }
                    
                    if let matchesUnw = self.viewModel.getMatchesRoundSorted(round: roundSelected){
                        MatchesList(matches: matchesUnw)
                    }
//                    else{
//                        Text("There are no matches for this round")
//                            .font(.title)
//                            .fontWeight(.bold)
//                    }
                    
                }
            }
        })
        .onAppear {
            self.viewModel.fetchData()
        }
    }
}

struct LeagueRoundsView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueRoundsView()
    }
}

