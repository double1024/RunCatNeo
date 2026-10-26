/*
 FrameImagesCollectionView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/06/03.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource
import Model
import SwiftUI

struct FrameImagesCollectionView: View {
    @Bindable var store: CustomRunnerEditor
    private let columns = [GridItem](repeating: .init(.flexible(), spacing: 4), count: 5)

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 4) {
                    ForEach(store.frameImages.enumerated(), id: \.element) { index, frameImage in
                        FrameImageCellView(
                            index: index,
                            frameImage: frameImage,
                            isTemplate: store.isTemplate,
                            isSelected: store.selectingFrameImage == frameImage
                        )
                        .onTapGesture {
                            Task {
                                await store.send(.frameImageCellTapped(frameImage))
                            }
                        }
                        .sortable(
                            index: index,
                            item: frameImage,
                            items: $store.frameImages,
                            draggingItem: $store.selectingFrameImage
                        )
                    }
                }
            }
            .background(Color(.controlBackgroundColor))
            .onTapGesture {
                Task {
                    await store.send(.collectionBackgroundTapped)
                }
            }
            .dropDestination(for: URL.self) { urls, _ in
                Task {
                    await store.send(.filesDropped(urls))
                }
                return true
            }
            Divider()
            HStack(spacing: 0) {
                Button {
                    Task {
                        await store.send(.addFrameButtonTapped)
                    }
                } label: {
                    Label {
                        Text("addFrame", bundle: .module)
                    } icon: {
                        Image(systemName: "plus")
                    }
                    .labelStyle(.iconOnly)
                }
                .buttonStyle(.segmented)
                .fileImporter(
                    isPresented: $store.showingFileImporter,
                    allowedContentTypes: [.png],
                    allowsMultipleSelection: true,
                    onCompletion: { result in
                        Task {
                            await store.send(.fileImporterResponse(result))
                        }
                    }
                )
                Button {
                    Task {
                        await store.send(.deleteFrameButtonTapped)
                    }
                } label: {
                    Label {
                        Text("deleteFrame", bundle: .module)
                    } icon: {
                        Image(systemName: "minus")
                    }
                    .labelStyle(.iconOnly)
                }
                .buttonStyle(.segmented)
                .disabled(store.selectingFrameImage == nil)
                Spacer()
            }
        }
        .frame(width: 256, height: 180) // 256 = 48 × 5 + 4 × 4
        .border(Color(.separatorColor))
    }
}
