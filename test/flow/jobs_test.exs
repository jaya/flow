defmodule Flow.JobsTest do
  use Flow.DataCase

  alias Flow.Jobs

  describe "clients" do
    alias Flow.Jobs.Client

    @valid_attrs %{description: "some description", logo: "some logo", name: "some name"}
    @update_attrs %{description: "some updated description", logo: "some updated logo", name: "some updated name"}
    @invalid_attrs %{description: nil, logo: nil, name: nil}

    def client_fixture(attrs \\ %{}) do
      {:ok, client} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Jobs.create_client()

      client
    end

    test "list_clients/0 returns all clients" do
      client = client_fixture()
      assert Jobs.list_clients() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = client_fixture()
      assert Jobs.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      assert {:ok, %Client{} = client} = Jobs.create_client(@valid_attrs)
      assert client.description == "some description"
      assert client.logo == "some logo"
      assert client.name == "some name"
    end

    test "create_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_client(@invalid_attrs)
    end

    test "update_client/2 with valid data updates the client" do
      client = client_fixture()
      assert {:ok, %Client{} = client} = Jobs.update_client(client, @update_attrs)
      assert client.description == "some updated description"
      assert client.logo == "some updated logo"
      assert client.name == "some updated name"
    end

    test "update_client/2 with invalid data returns error changeset" do
      client = client_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.update_client(client, @invalid_attrs)
      assert client == Jobs.get_client!(client.id)
    end

    test "delete_client/1 deletes the client" do
      client = client_fixture()
      assert {:ok, %Client{}} = Jobs.delete_client(client)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_client!(client.id) end
    end

    test "change_client/1 returns a client changeset" do
      client = client_fixture()
      assert %Ecto.Changeset{} = Jobs.change_client(client)
    end
  end

  describe "jobs" do
    alias Flow.Jobs.Job

    @valid_attrs %{description: "some description", name: "some name", positions: 42}
    @update_attrs %{description: "some updated description", name: "some updated name", positions: 43}
    @invalid_attrs %{description: nil, name: nil, positions: nil}

    def job_fixture(attrs \\ %{}) do
      {:ok, job} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Jobs.create_job()

      job
    end

    test "list_jobs/0 returns all jobs" do
      job = job_fixture()
      assert Jobs.list_jobs() == [job]
    end

    test "get_job!/1 returns the job with given id" do
      job = job_fixture()
      assert Jobs.get_job!(job.id) == job
    end

    test "create_job/1 with valid data creates a job" do
      assert {:ok, %Job{} = job} = Jobs.create_job(@valid_attrs)
      assert job.description == "some description"
      assert job.name == "some name"
      assert job.positions == 42
    end

    test "create_job/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_job(@invalid_attrs)
    end

    test "update_job/2 with valid data updates the job" do
      job = job_fixture()
      assert {:ok, %Job{} = job} = Jobs.update_job(job, @update_attrs)
      assert job.description == "some updated description"
      assert job.name == "some updated name"
      assert job.positions == 43
    end

    test "update_job/2 with invalid data returns error changeset" do
      job = job_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.update_job(job, @invalid_attrs)
      assert job == Jobs.get_job!(job.id)
    end

    test "delete_job/1 deletes the job" do
      job = job_fixture()
      assert {:ok, %Job{}} = Jobs.delete_job(job)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_job!(job.id) end
    end

    test "change_job/1 returns a job changeset" do
      job = job_fixture()
      assert %Ecto.Changeset{} = Jobs.change_job(job)
    end
  end

  describe "status" do
    alias Flow.Jobs.Status

    @valid_attrs %{description: "some description", enable: true, name: "some name", order: 42}
    @update_attrs %{description: "some updated description", enable: false, name: "some updated name", order: 43}
    @invalid_attrs %{description: nil, enable: nil, name: nil, order: nil}

    def status_fixture(attrs \\ %{}) do
      {:ok, status} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Jobs.create_status()

      status
    end

    test "list_status/0 returns all status" do
      status = status_fixture()
      assert Jobs.list_status() == [status]
    end

    test "get_status!/1 returns the status with given id" do
      status = status_fixture()
      assert Jobs.get_status!(status.id) == status
    end

    test "create_status/1 with valid data creates a status" do
      assert {:ok, %Status{} = status} = Jobs.create_status(@valid_attrs)
      assert status.description == "some description"
      assert status.enable == true
      assert status.name == "some name"
      assert status.order == 42
    end

    test "create_status/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_status(@invalid_attrs)
    end

    test "update_status/2 with valid data updates the status" do
      status = status_fixture()
      assert {:ok, %Status{} = status} = Jobs.update_status(status, @update_attrs)
      assert status.description == "some updated description"
      assert status.enable == false
      assert status.name == "some updated name"
      assert status.order == 43
    end

    test "update_status/2 with invalid data returns error changeset" do
      status = status_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.update_status(status, @invalid_attrs)
      assert status == Jobs.get_status!(status.id)
    end

    test "delete_status/1 deletes the status" do
      status = status_fixture()
      assert {:ok, %Status{}} = Jobs.delete_status(status)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_status!(status.id) end
    end

    test "change_status/1 returns a status changeset" do
      status = status_fixture()
      assert %Ecto.Changeset{} = Jobs.change_status(status)
    end
  end

  describe "technologies" do
    alias Flow.Jobs.Technology

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def technology_fixture(attrs \\ %{}) do
      {:ok, technology} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Jobs.create_technology()

      technology
    end

    test "list_technologies/0 returns all technologies" do
      technology = technology_fixture()
      assert Jobs.list_technologies() == [technology]
    end

    test "get_technology!/1 returns the technology with given id" do
      technology = technology_fixture()
      assert Jobs.get_technology!(technology.id) == technology
    end

    test "create_technology/1 with valid data creates a technology" do
      assert {:ok, %Technology{} = technology} = Jobs.create_technology(@valid_attrs)
      assert technology.description == "some description"
      assert technology.name == "some name"
    end

    test "create_technology/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_technology(@invalid_attrs)
    end

    test "update_technology/2 with valid data updates the technology" do
      technology = technology_fixture()
      assert {:ok, %Technology{} = technology} = Jobs.update_technology(technology, @update_attrs)
      assert technology.description == "some updated description"
      assert technology.name == "some updated name"
    end

    test "update_technology/2 with invalid data returns error changeset" do
      technology = technology_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.update_technology(technology, @invalid_attrs)
      assert technology == Jobs.get_technology!(technology.id)
    end

    test "delete_technology/1 deletes the technology" do
      technology = technology_fixture()
      assert {:ok, %Technology{}} = Jobs.delete_technology(technology)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_technology!(technology.id) end
    end

    test "change_technology/1 returns a technology changeset" do
      technology = technology_fixture()
      assert %Ecto.Changeset{} = Jobs.change_technology(technology)
    end
  end

  describe "candidates" do
    alias Flow.Jobs.Candidate

    @valid_attrs %{email: "some email", github: "some github", linkedin: "some linkedin", name: "some name", phone: "some phone"}
    @update_attrs %{email: "some updated email", github: "some updated github", linkedin: "some updated linkedin", name: "some updated name", phone: "some updated phone"}
    @invalid_attrs %{email: nil, github: nil, linkedin: nil, name: nil, phone: nil}

    def candidate_fixture(attrs \\ %{}) do
      {:ok, candidate} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Jobs.create_candidate()

      candidate
    end

    test "list_candidates/0 returns all candidates" do
      candidate = candidate_fixture()
      assert Jobs.list_candidates() == [candidate]
    end

    test "get_candidate!/1 returns the candidate with given id" do
      candidate = candidate_fixture()
      assert Jobs.get_candidate!(candidate.id) == candidate
    end

    test "create_candidate/1 with valid data creates a candidate" do
      assert {:ok, %Candidate{} = candidate} = Jobs.create_candidate(@valid_attrs)
      assert candidate.email == "some email"
      assert candidate.github == "some github"
      assert candidate.linkedin == "some linkedin"
      assert candidate.name == "some name"
      assert candidate.phone == "some phone"
    end

    test "create_candidate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_candidate(@invalid_attrs)
    end

    test "update_candidate/2 with valid data updates the candidate" do
      candidate = candidate_fixture()
      assert {:ok, %Candidate{} = candidate} = Jobs.update_candidate(candidate, @update_attrs)
      assert candidate.email == "some updated email"
      assert candidate.github == "some updated github"
      assert candidate.linkedin == "some updated linkedin"
      assert candidate.name == "some updated name"
      assert candidate.phone == "some updated phone"
    end

    test "update_candidate/2 with invalid data returns error changeset" do
      candidate = candidate_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.update_candidate(candidate, @invalid_attrs)
      assert candidate == Jobs.get_candidate!(candidate.id)
    end

    test "delete_candidate/1 deletes the candidate" do
      candidate = candidate_fixture()
      assert {:ok, %Candidate{}} = Jobs.delete_candidate(candidate)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_candidate!(candidate.id) end
    end

    test "change_candidate/1 returns a candidate changeset" do
      candidate = candidate_fixture()
      assert %Ecto.Changeset{} = Jobs.change_candidate(candidate)
    end
  end

  describe "skills" do
    alias Flow.Jobs.Skill

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def skill_fixture(attrs \\ %{}) do
      {:ok, skill} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Jobs.create_skill()

      skill
    end

    test "list_skills/0 returns all skills" do
      skill = skill_fixture()
      assert Jobs.list_skills() == [skill]
    end

    test "get_skill!/1 returns the skill with given id" do
      skill = skill_fixture()
      assert Jobs.get_skill!(skill.id) == skill
    end

    test "create_skill/1 with valid data creates a skill" do
      assert {:ok, %Skill{} = skill} = Jobs.create_skill(@valid_attrs)
    end

    test "create_skill/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_skill(@invalid_attrs)
    end

    test "update_skill/2 with valid data updates the skill" do
      skill = skill_fixture()
      assert {:ok, %Skill{} = skill} = Jobs.update_skill(skill, @update_attrs)
    end

    test "update_skill/2 with invalid data returns error changeset" do
      skill = skill_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.update_skill(skill, @invalid_attrs)
      assert skill == Jobs.get_skill!(skill.id)
    end

    test "delete_skill/1 deletes the skill" do
      skill = skill_fixture()
      assert {:ok, %Skill{}} = Jobs.delete_skill(skill)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_skill!(skill.id) end
    end

    test "change_skill/1 returns a skill changeset" do
      skill = skill_fixture()
      assert %Ecto.Changeset{} = Jobs.change_skill(skill)
    end
  end
end
