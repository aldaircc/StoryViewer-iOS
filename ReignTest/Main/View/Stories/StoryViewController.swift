//
//  ViewController.swift
//  ReignTest
//
//  Created by Aldair Raul Cosetito Coral on 11/06/21.
//

import UIKit

class StoryViewController: UIViewController {
    
    //MARK: - UI Controls
    let storiesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.rowHeight = 80
        return tableView
    }()
    lazy var refreshcontrol: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.black
        return refreshControl
    }()
    
    //MARK: - Local variables
    var viewModel: StoryViewModel = StoryViewModel()
    let storyCellIdentifier = "storyCell"
    var stories = [StoryModel]()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAction()
    }
    
    //MARK: - Methods
    fileprivate func configureTableView() {
        self.view.addSubview(storiesTableView)
        self.storiesTableView.addSubview(refreshcontrol)
        NSLayoutConstraint.activate([
            storiesTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
            storiesTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            storiesTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            storiesTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    fileprivate func registerTableView() {
        self.storiesTableView.delegate = self
        self.storiesTableView.dataSource = self
        self.storiesTableView.register(StoryCell.self, forCellReuseIdentifier: storyCellIdentifier)
    }
    
    fileprivate func setupUI() {
        configureTableView()
    }
    
    fileprivate func setupAction() {
        registerTableView()
        getData()
    }
    
    fileprivate func getData() {
        self.viewModel.getStories(completion: { stories in
            self.stories = []
            self.stories = stories
            DispatchQueue.main.async {
                self.storiesTableView.reloadData()
            }
        })
    }
    
    fileprivate func goToShowDetail(storyModel: StoryModel) {
        guard let url = storyModel.storyURL, url != "" else { return }
        self.viewModel.goToStoryDetail(url)
    }
    
    @IBAction func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.getData()
        self.storiesTableView.reloadData()
        self.refreshcontrol.endRefreshing()
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension StoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: storyCellIdentifier, for: indexPath) as? StoryCell
        let story = self.stories[indexPath.row]
        cell?.setupUI(story)
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = self.stories[indexPath.row]
        self.goToShowDetail(storyModel: story)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let story = self.stories[indexPath.row]
            self.stories.remove(at: indexPath.row)
            self.viewModel.deleteStory(story: story)
            self.storiesTableView.reloadData()
        }
    }
}
