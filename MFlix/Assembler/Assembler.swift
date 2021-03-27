//
//  Assembler.swift
//  MFlix
//
//  Created by Viet Anh on 5/22/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol Assembler: class,
    SeeAllAssembler,
    MovieDetailAssembler,
    SearchAssembler,
    FavoriteAssembler,
    WatchNowAssembler,
    AppAssembler,
    RepositoriesAssembler {
    
}

final class DefaultAssembler: Assembler {
}
