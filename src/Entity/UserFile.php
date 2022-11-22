<?php

namespace App\Entity;

use App\Repository\UserFileRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: UserFileRepository::class)]
class UserFile
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $user_id = null;

    #[ORM\OneToMany(mappedBy: 'userFile', targetEntity: File::class)]
    private Collection $file_id;

    #[ORM\Column]
    private ?\DateTimeImmutable $created_at = null;

    #[ORM\Column]
    private ?\DateTimeImmutable $updated_at = null;

    public function __construct()
    {
        $this->file_id = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUserId(): ?string
    {
        return $this->user_id;
    }

    public function setUserId(string $user_id): self
    {
        $this->user_id = $user_id;

        return $this;
    }

    /**
     * @return Collection<int, File>
     */
    public function getFileId(): Collection
    {
        return $this->file_id;
    }

    public function addFileId(File $fileId): self
    {
        if (!$this->file_id->contains($fileId)) {
            $this->file_id->add($fileId);
            $fileId->setUserFile($this);
        }

        return $this;
    }

    public function removeFileId(File $fileId): self
    {
        if ($this->file_id->removeElement($fileId)) {
            // set the owning side to null (unless already changed)
            if ($fileId->getUserFile() === $this) {
                $fileId->setUserFile(null);
            }
        }

        return $this;
    }

    public function getCreatedAt(): ?\DateTimeImmutable
    {
        return $this->created_at;
    }

    public function setCreatedAt(\DateTimeImmutable $created_at): self
    {
        $this->created_at = $created_at;

        return $this;
    }

    public function getUpdatedAt(): ?\DateTimeImmutable
    {
        return $this->updated_at;
    }

    public function setUpdatedAt(\DateTimeImmutable $updated_at): self
    {
        $this->updated_at = $updated_at;

        return $this;
    }
}
