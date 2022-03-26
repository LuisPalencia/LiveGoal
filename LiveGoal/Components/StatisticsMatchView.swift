//
//  StatisticsMatchView.swift
//  FootballApp
//
//  Created by CICE on 25/03/2022.
//

import SwiftUI

struct StatisticsMatchView: View {
    
    var matchStatistics: MatchStatisticsViewModel = MatchStatisticsViewModel(id: 720979, teamIdHome: 531, shotsOnGoalHome: 8, shotsOffGoalHome: 8, totalShotsHome: 18, blockedShotsHome: 2,shotsInsideBoxHome: 12, shotsOutsideBoxHome: 6, foulsHome: 9, cornersHome: 6, offsidesHome: 4, ballPossessionHome: 47, yellowCardsHome: 4, redCardsHome: nil, goalkeeperSavesHome: 2, totalPassesHome: 344, totalSuccessfulPassesHome: 252, passesSuccessfulPercentageHome: 73, teamIdAway: 548, shotsOnGoalAway: 2, shotsOffGoalAway: 4, totalShotsAway: 9, blockedShotsAway: 2, shotsInsideBoxAway: 5, shotsOutsideBoxAway: 4, foulsAway: 9, cornersAway: 4, offsidesAway: nil, ballPossessionAway: 53, yellowCardsAway: 1, redCardsAway: nil, goalkeeperSavesAway: 4, totalPassesAway: 408, totalSuccessfulPassesAway: 326, passesSuccessfulPercentageAway: 80)
    
    var body: some View {
            VStack(spacing: 0, content: {
                
                VStack{
                    HStack{
                        Text("\(self.matchStatistics.ballPossessionHome ?? 0)%")
                            .font(.headline)
                        Spacer()
                        Text("Possession")
                            .font(.headline)
                        Spacer()
                        Text("\(self.matchStatistics.ballPossessionAway ?? 0)%")
                            .font(.headline)
                        
                    }
                    ProgressBar(value: self.matchStatistics.possessionHomeDecimal).frame(height: 20)
                    
                }
                .padding(.top, 20)
                .padding(.bottom, 10)
                .padding([.leading, .trailing], 20)
                .background(Color.white.opacity(1))
                
                VStack{
                    HStack{
                        Text("\(self.matchStatistics.totalShotsHome ?? 0)")
                            .font(.headline)
                        Spacer()
                        Text("Shots")
                            .font(.headline)
                        Spacer()
                        Text("\(self.matchStatistics.totalShotsAway ?? 0)")
                            .font(.headline)
                        
                    }
                    ProgressBar(value: self.matchStatistics.totalShotsHomePercentageDecimal).frame(height: 20)
                }
                .padding(.top, 20)
                .padding(.bottom, 10)
                .padding([.leading, .trailing], 20)
                .background(Color.black.opacity(0.1))
                
                
                VStack{
                    HStack{
                        Text("\(self.matchStatistics.shotsOnGoalHome ?? 0)")
                            .font(.headline)
                        Spacer()
                        Text("Shots on goal")
                            .font(.headline)
                        Spacer()
                        Text("\(self.matchStatistics.shotsOnGoalAway ?? 0)")
                            .font(.headline)
                        
                    }
                    ProgressBar(value: self.matchStatistics.shotsOnGoalHomePercentageDecimal).frame(height: 20)
                }
                .padding(.top, 20)
                .padding(.bottom, 10)
                .padding([.leading, .trailing], 20)
                .background(Color.white.opacity(1))
                
                
                VStack{
                    HStack{
                        Text("\(self.matchStatistics.cornersHome ?? 0)")
                            .font(.headline)
                        Spacer()
                        Text("Corners")
                            .font(.headline)
                        Spacer()
                        Text("\(self.matchStatistics.cornersAway ?? 0)")
                            .font(.headline)
                        
                    }
                    ProgressBar(value: self.matchStatistics.cornersHomePercentageDecimal).frame(height: 20)
                }
                .padding(.top, 20)
                .padding(.bottom, 10)
                .padding([.leading, .trailing], 20)
                .background(Color.black.opacity(0.1))
                
                VStack{
                    HStack{
                        Text("\(self.matchStatistics.offsidesHome ?? 0)")
                            .font(.headline)
                        Spacer()
                        Text("Offsides")
                            .font(.headline)
                        Spacer()
                        Text("\(self.matchStatistics.offsidesAway ?? 0)")
                            .font(.headline)
                        
                    }
                    ProgressBar(value: self.matchStatistics.offsidesHomePercentageDecimal).frame(height: 20)

                }
                .padding(.top, 20)
                .padding(.bottom, 10)
                .padding([.leading, .trailing], 20)
                .background(Color.white.opacity(1))
                
                VStack{
                    HStack{
                        Text("\(self.matchStatistics.goalkeeperSavesHome ?? 0)")
                            .font(.headline)
                        Spacer()
                        Text("Goalkeeper saves")
                            .font(.headline)
                        Spacer()
                        Text("\(self.matchStatistics.goalkeeperSavesAway ?? 0)")
                            .font(.headline)
                        
                    }
                    ProgressBar(value: self.matchStatistics.goalkeeperSavesHomePercentageDecimal).frame(height: 20)
                }
                .padding(.top, 20)
                .padding(.bottom, 10)
                .padding([.leading, .trailing], 20)
                .background(Color.black.opacity(0.1))
                
                VStack{
                    HStack{
                        Text("\(self.matchStatistics.yellowCardsHome ?? 0)")
                            .font(.headline)
                        Spacer()
                        Text("Yellow cards")
                            .font(.headline)
                        Spacer()
                        Text("\(self.matchStatistics.yellowCardsAway ?? 0)")
                            .font(.headline)
                        
                    }
                    ProgressBar(value: self.matchStatistics.yellowCardsHomePercentageDecimal).frame(height: 20)
                }
                .padding(.top, 20)
                .padding(.bottom, 10)
                .padding([.leading, .trailing], 20)
                .background(Color.white.opacity(1))
                
                VStack{
                    HStack{
                        Text("\(self.matchStatistics.redCardsHome ?? 0)")
                            .font(.headline)
                        Spacer()
                        Text("Red cards")
                            .font(.headline)
                        Spacer()
                        Text("\(self.matchStatistics.redCardsAway ?? 0)")
                            .font(.headline)
                        
                    }
                    ProgressBar(value: self.matchStatistics.redCardsHomePercentageDecimal).frame(height: 20)

                }
                .padding(.top, 20)
                .padding(.bottom, 10)
                .padding([.leading, .trailing], 20)
                .background(Color.black.opacity(0.1))
                
            })
        }
}

struct StatisticsMatchView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsMatchView()
    }
}
